# Web Automation Framework Empowered by Local AI Agents
# Copyright (C) 2026  A. Furkan KIZILTEPE <furkan.kiziltepe@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
import gc
import sys
from pathlib import Path

from ollama import ResponseError

from ai_agents.core.config import get_agent_model
from ai_agents.core.lessons_learned_manager import LessonsLearnedManager
from ai_agents.core.model_selector import print_missing_model_error
from ai_agents.core.schemas import FeatureSuite
from ai_agents.core.step_library import PatternRegistry, get_escaped_step_patterns
from ai_agents.core.tradehub_domain import TRADEHUB_RAW_INSTRUCTIONS, TRADEHUB_BUSINESS_KNOWLEDGE
from ai_agents.core.utils import sanitize_model_tag_for_filename, split_instructions_into_sections, \
    discover_all_feature_files, harvest_page_elements, parse_feature_files, \
    save_all_locators_to_ini, audit_steps_via_behave
from ai_agents.qa_automation_feasibility_agent.pattern_audit_agent import PatternAuditAgent
from ai_agents.qa_automation_feasibility_agent.pattern_parameter_resolution_agent import PatternResolutionAgent
from ai_agents.qa_automation_feasibility_agent.test_automatable_feasibility_agent import AutomationFeasibilityAgent
from ai_agents.qa_coach_agent.test_autamation_feasibility_coach import AutomationFeasibilityCoachAgent
from ai_agents.qa_coach_agent.test_generation_coach import TestGenerationCoachAgent
from ai_agents.qa_coach_agent.test_step_audit_coach import AuditCoachAgent
from ai_agents.qa_coach_agent.test_step_implementation_generation_coach import StepImplementationGenerationCoachAgent
from ai_agents.qa_coverage_planner_agent.test_coverage_planner_agent import CoveragePlannerAgent
from ai_agents.qa_locator_generator_agent.locator_generator_agent import LocatorGeneratorAgent
from ai_agents.qa_test_fixer_agent.test_fixer_agent import TestFixerAgent
from ai_agents.qa_test_generator_agent.test_generator import TestGeneratorAgent
from ai_agents.core.utils import collect_raw_steps, mine_patterns_with_drain
from ai_agents.qa_test_step_generator_agent.test_step_generator import StepGeneratorAgent
from ai_agents.qa_test_step_generator_agent.test_step_reviewer import StepReviewAgent
from ai_agents.qa_test_step_generator_agent.test_step_skeleton_generator import StepSkeletonGeneratorAgent
from utilities.web_driver import get_driver


class Orchestrator:
    def __init__(self):
        self.model_slug = sanitize_model_tag_for_filename(get_agent_model("TestGeneratorAgent"))
        self.test_gen_coach = TestGenerationCoachAgent()
        self.coverage_planner = CoveragePlannerAgent()
        self.test_generator = TestGeneratorAgent()
        self.feasibility_coach = AutomationFeasibilityCoachAgent()
        self.feasibility_agent = AutomationFeasibilityAgent()
        self.pattern_auditor = PatternAuditAgent()
        self.resolution_agent = PatternResolutionAgent(interactive_mode='n')
        self.test_fixer_agent = TestFixerAgent()
        self.lessons_manager = LessonsLearnedManager()
        self.audit_coach = AuditCoachAgent(lessons_manager=self.lessons_manager)
        self.step_impl_coach = StepImplementationGenerationCoachAgent(lessons_manager=self.lessons_manager)
        self.skeleton_agent = StepSkeletonGeneratorAgent()
        self.step_generator_agent = StepGeneratorAgent()
        self.step_reviewer_agent = StepReviewAgent()
        self.locator_generator_agent = LocatorGeneratorAgent()
        self.project_root = Path.cwd()
        self.features_dir = self.project_root / "features"
        self.feature_files = discover_all_feature_files(str(self.features_dir), model_slug=self.model_slug)

    def orchestrate(self):
        self.test_generation()
        self.automation_feasibility()
        self.audit()
        self.code_generation()

    @staticmethod
    def generate_tests(section: str, first_line: str, coverage_planner: CoveragePlannerAgent,
                       test_generator: TestGeneratorAgent) -> FeatureSuite:
        try:
            print("        🤖 [Coverage Planner Agent]: Planning test scenario coverage matrix...")
            coverage_plan = coverage_planner.plan_coverage(
                requirement_text=section,
                requirement_section=first_line
            )
            print(f"            Planned {coverage_plan.total_scenarios_planned} test scenario(s).")

            # -----------------------------------------------------------------
            # PHASE 1: Generate Schema-Validated Gherkin FeatureSuite
            # -----------------------------------------------------------------
            print("        🤖 [Test Generator Agent]: Synthesizing Gherkin feature suite...")

            BATCH_SIZE = 6  # Small batch size to avoid output token limits
            all_scenarios = []
            feature_title = ""

            planned_scenarios = coverage_plan.scenarios
            total_scenarios = len(planned_scenarios)

            for i in range(0, total_scenarios, BATCH_SIZE):
                batch = planned_scenarios[i: i + BATCH_SIZE]

                # Create a temporary plan for this sub-batch
                batch_plan = coverage_plan.model_copy(update={"scenarios": batch})

                batch_suite = test_generator.generate_tests_for_instructions(
                    coverage_plan=batch_plan,
                    step_patterns=get_escaped_step_patterns(),
                    business_knowledge=TRADEHUB_BUSINESS_KNOWLEDGE
                )

                if not feature_title and hasattr(batch_suite, "feature_title"):
                    feature_title = batch_suite.feature_title

                all_scenarios.extend(batch_suite.scenarios)

            # Build the complete merged suite
            feature_suite = FeatureSuite(
                feature_title=feature_title or first_line,
                scenarios=all_scenarios
            )
            return feature_suite

        except ResponseError as e:
            if e.status_code == 404 or "not found" in str(e).lower():
                print_missing_model_error(test_generator.model_name)
                sys.exit(1)
            else:
                raise e

    def test_generation(self):
        sections = split_instructions_into_sections(TRADEHUB_RAW_INSTRUCTIONS)
        print(f"📄 Found {len(sections)} distinct section(s) to process...")
        print("🔄 Phase 0: Planning Test Generation Pipeline...")
        print("    🤖 [Test Generation Coach Agent]: Evaluating requirements sections vs existing root feature files...")
        coach_response = self.test_gen_coach.evaluate_execution(
            requirements_doc=TRADEHUB_RAW_INSTRUCTIONS,
            existing_features_summary=self.test_gen_coach.get_section_summary(sections, model_slug=self.model_slug)
        )
        directives_by_index = {target.section_index: target for target in coach_response.target_scope}
        for index, section in enumerate(sections, 1):
            first_line = section.split('\n')[0].strip()
            directive = directives_by_index.get(index)

            # Fallback guard: skip if file exists and no explicit re-generation is requested
            if not directive or directive.action == "SKIP":
                print(f"    ⏩ [Coach Directive] SKIP [{index}/{len(sections)}]: {first_line}")
                continue

            print(f"    🎯 [Coach Directive]: {directive.action} [{index}/{len(sections)}]: {first_line}")
            print(f"    📋 Reason: {directive.reason}")

            # Trigger Coverage Planner & Test Generator ONLY for this specific section
            feature_suite = self.generate_tests(
                section=section,
                first_line=first_line,
                coverage_planner=self.coverage_planner,
                test_generator=self.test_generator
            )

            # Write FeatureSuite to disk
            file_path = Path("features") / directive.feature_file_name
            with open(file_path, "w", encoding="utf-8") as f:
                f.write(f"Feature: {feature_suite.feature_title}\n\n")
                for scenario in feature_suite.scenarios:
                    if scenario.tag:
                        f.write(f"  {scenario.tag}\n")
                    f.write(f"  Scenario: {scenario.name}\n")
                    for step in scenario.steps:
                        f.write(f"    {step.keyword} {step.statement}\n")
                    f.write("\n")

            print(f"        ✅ Generated: {directive.feature_file_name}\n")

    def automation_feasibility(self):
        print("🔄 Phase 1: Automation Feasibility & Pattern Mining Pipeline...")
        print("    🤖 [Feasibility Coach]: Evaluating feature feasibility status...")
        feasibility_coach_response = self.feasibility_coach.evaluate_execution()
        directives_map = {target.feature_file_name: target for target in feasibility_coach_response.target_scope}
        if feasibility_coach_response.should_run_feasibility:
            print("    🔍 Phase 1.1: Collecting initial undefined steps...")
            feature_steps_map, all_raw_steps = collect_raw_steps(self.feature_files)
            print("    🔍 Phase 1.2: Mining Drain3 patterns and evaluating feasibility...")
            drain_patterns = mine_patterns_with_drain(all_raw_steps)
            automatable_patterns = {p for p in drain_patterns if "<*>" in p}
            registry = PatternRegistry(initial_patterns=automatable_patterns)
            features_dir = Path("features")
            root_feature_files = [f for f in features_dir.glob("*.feature") if f.is_file()]
            for feature_file in root_feature_files:
                directive = directives_map.get(feature_file.name)
                if directive and directive.action in ["EVALUATE", "RE_EVALUATE"]:
                    print(f"    🎯 [Coach Directive]: {directive.action} -> {feature_file.name}")
                    print(f"    📋 Reason: {directive.reason}")
                    print(f"    🤖 [Feasibility Agent]: Generating feasibility report for {feature_file.name}...")
                    self.feasibility_agent.process_feature_file(str(feature_file), registry)
                else:
                    print(f"    ⏩ [Coach Directive] SKIP -> {feature_file.name} (Feedback intact)")
        else:
            print("    ⏩ [Feasibility Coach]: All feasibility feedback reports are valid and up to date.")

    def audit(self):
        print("🔄 Phase 2: Audit Pipeline...")
        print("    🔍 Phase 2.1: Harvesting known patterns from existing feedback JSON files...")
        harvested_patterns = PatternRegistry.collect_all_used_patterns(feedback_dir="features")
        pattern_registry = PatternRegistry(initial_patterns=harvested_patterns)
        print(f"    📋 PatternRegistry loaded with {len(pattern_registry.active_patterns)} unique active patterns.")
        print("    🤖 [Audit Coach]: Evaluating audit execution scope...")

        audit_coach_response = self.audit_coach.evaluate_audit_execution()
        audit_directives_map = {target.feature_file_name: target for target in audit_coach_response.target_scope}
        if audit_coach_response.should_run_audit:
            features_dir = Path("features")
            root_feature_files = [f for f in features_dir.glob("*.feature") if f.is_file()]
            for feature_file in root_feature_files:
                directive = audit_directives_map.get(feature_file.name)
                if directive and directive.action == "EXECUTE_AUDIT":
                    print(f"    🎯 [Coach Directive]: EXECUTE_AUDIT -> {feature_file.name}")
                    print(f"    📋 Reason: {directive.reason}")
                    self.pattern_auditor.audit_and_remediate_feature(
                        feature_path=str(feature_file),
                        registry=pattern_registry,
                        rematch_fn=self.feasibility_agent.rematch_step,
                        lessons_manager=self.lessons_manager
                    )
                    print("\n🔧 Phase 3.1: Harmonizing Gherkin step syntax for automatable scenarios...")
                    resolution_agent = PatternResolutionAgent(interactive_mode='n')
                    test_fixer_agent = TestFixerAgent()

                    for file in [feature_file]:
                        feature_path = Path(file)
                        feedback_file = feature_path.parent / f"{feature_path.stem}_feasibility_feedback.json"

                        if feedback_file.exists():
                            resolution_agent.process_feedback_file(str(feedback_file))

                            fix_result = test_fixer_agent.fix_feature_file(
                                feature_path=str(feature_path),
                                feedback_path=str(feedback_file)
                            )

                            fixed_gherkin = fix_result.get("harmonized_gherkin", "")
                            fixes_applied = fix_result.get("fixes_applied", [])

                            if fixed_gherkin:
                                feature_path.write_text(fixed_gherkin, encoding="utf-8")

                            if fixes_applied:
                                print(f"   📝 Applied {len(fixes_applied)} fix(es) to {feature_path.name}")
                                for fix in fixes_applied:
                                    self.lessons_manager.add_lesson(
                                        agent_id="TestGeneratorAgent",
                                        category=fix.get("category", "gherkin_syntax"),
                                        original_output=fix.get("original_step", ""),
                                        corrected_output=fix.get("corrected_step", ""),
                                        root_cause=fix.get("root_cause", ""),
                                        rule_derived=fix.get("rule_derived", "")
                                    )

                    del resolution_agent, test_fixer_agent
                    gc.collect()
                else:
                    print(f"    ⏩ [Coach Directive]: SKIP_AUDIT -> {feature_file.name} (All resolved_patterns intact)")

            del self.pattern_auditor, self.feasibility_agent
            gc.collect()
        else:
            print("    ⏩ [Audit Coach]: All feedback files have complete, valid resolved_patterns.")

    def code_generation(self):
        print("🔄 Phase 3: Evaluating Step Definition & Code Generation Pipeline...")
        feature_steps_map, all_raw_steps = collect_raw_steps(self.feature_files)
        step_status = audit_steps_via_behave(self.feature_files)
        latest_patterns = False if len(all_raw_steps) == 0 else PatternRegistry.collect_all_used_patterns(
            feedback_dir="features")
        if not latest_patterns:
            print("⏩ Phase 3 Skipped: No active step patterns found in feedback directory.")
        else:
            # 2. Extract existing step definitions from features/steps
            existing_step_files = list(Path("features/steps").glob("*.py")) if Path("features/steps").exists() else []
            existing_step_definitions = [step_file.read_text(encoding="utf-8") for step_file in existing_step_files]

            # 3. Invoke Phase 4 Coach Gatekeeper

            coach_response = self.step_impl_coach.evaluate_execution(
                step_status_report=step_status,
                existing_step_definitions=existing_step_definitions
            )
            ## del self.step_impl_coach
            gc.collect()

            if coach_response.should_run_generator:
                print(f"    🤖 [Audit Coach]: Evaluating audit execution scope...")
                # Filter patterns flagged strictly for GENERATE
                unhandled_patterns = [
                    target.step_pattern
                    for target in coach_response.target_scope
                    if target.action == "GENERATE"
                ]
                unhandled_pattern_set = set(unhandled_patterns)
                output_file = Path("features/steps/generated_by_ai_steps.py")
                if False:
                    print(
                        f"    🔍 Phase 3.1: Generating step skeletons for {len(unhandled_patterns)} unhandled pattern(s)...")

                    skeletons = self.skeleton_agent.generate_skeletons(unhandled_pattern_set, unhandled_patterns)
                    del self.skeleton_agent
                    gc.collect()

                    if skeletons:
                        combined_skeletons = "\n\n".join(skeletons)

                        print("    🔍 Phase 3.2: Generating Python @step implementation code...")

                        draft_code = self.step_generator_agent.generate_missing_steps(combined_skeletons)
                        del self.step_generator_agent
                        gc.collect()

                        print("    🧹 Phase 3.3: Reviewing, sanitizing, and validating AST with Ruff...")

                        cleaned_final_code = self.step_reviewer_agent.review_and_fix(draft_code)
                        del self.step_reviewer_agent
                        gc.collect()

                        # Write out final generated step file
                        output_file = Path("features/steps/generated_by_ai_steps.py")
                        output_file.parent.mkdir(parents=True, exist_ok=True)
                        with open(output_file, "a" if output_file.exists() else "w", encoding="utf-8") as out_f:
                            out_f.write("\n\n" + cleaned_final_code + "\n")

                        print(f"    ✅ Generated step definitions appended to {output_file.resolve()}")
                else:
                    for target in coach_response.target_scope:
                        action = target.action
                        pattern = target.step_pattern

                        content = output_file.read_text(encoding="utf-8")
                        blocks = content.split("\n@step")
                        if action == "REMOVE":
                            cleaned_blocks = []
                            for i, block in enumerate(blocks):
                                block_text = "@step" + block if i > 0 else block
                                if f"('{pattern}')" in block or f'("{pattern}")' in block:
                                    print(f"🗑️ Removing step definition for: '{pattern}'")
                                    continue
                                cleaned_blocks.append(block_text)

                            output_file.write_text("\n".join(cleaned_blocks) + "\n", encoding="utf-8")
                            print(f"🗑️ Successfully removed step definition for: '{pattern}'")
                            # Find and delete the exact function/decorator block matching this pattern
                            # remove_step_from_file(file_path, pattern)

                        elif action == "REFACTOR":
                            # Call your review/refactoring agent to rewrite this specific step block
                            # refactor_step_in_file(file_path, pattern, target.reason)
                            pass
                    print("⏩ [Audit Coach]: Generator was flagged, but no specific patterns required GENERATE.")
                    return True
            else:
                print(
                    "⏩ [Audit Coach]: All step definitions are already implemented or skipped. No code generation "
                    "required.")

    def locator_generation(self):
        print("🔄 Phase 4: Locator Generation Pipeline...")
        scenarios = parse_feature_files()
        all_locators = []
        for scenario in scenarios:
            print(f"    🔍 Phase 4.1: Generating locators for scenario: {scenario['title']}")
            elements = harvest_page_elements(get_driver("chrome"), scenario['page_url'])
            locators = self.locator_generator_agent.generate_locators(scenario["raw_text"], elements)
            all_locators.extend(locators.sections)
        save_all_locators_to_ini(all_locators, output_dir="elements", file_name="generated_by_ai_locators.ini")
        print("    ✅ Generated locators:")
