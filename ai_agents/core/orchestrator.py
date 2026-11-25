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
import time
from pathlib import Path
from typing import List, Optional

from ollama import ResponseError

from ai_agents.core.base_agent import BaseAgent
from ai_agents.core.config import get_agent_model
from ai_agents.core.lessons_learned_manager import LessonsLearnedManager
from ai_agents.core.model_selector import print_missing_model_error
from ai_agents.core.schemas import FeatureSuite, RouterDecision, SCHEMA_REGISTRY, get_output_schema
from ai_agents.core.skill_loader import SkillLoader
from ai_agents.core.step_library import PatternRegistry, get_escaped_step_patterns
from ai_agents.core.domain import RAW_INSTRACTIONS, BUSINESS_KNOWLEDGE, DOCUMENT
from ai_agents.core.utils import sanitize_model_tag_for_filename, split_instructions_into_sections, \
    discover_all_feature_files, harvest_page_elements, parse_feature_files, \
    save_all_locators_to_ini, audit_steps_via_behave, rest_check, login_to_app, get_step_patterns, \
    load_framework_utilities, get_section_summary
from ai_agents.qa_automation_feasibility_agent.pattern_audit_agent import PatternAuditAgent
from ai_agents.qa_automation_feasibility_agent.pattern_parameter_resolution_agent import PatternResolutionAgent
from ai_agents.qa_automation_feasibility_agent.test_automatable_feasibility_agent import AutomationFeasibilityAgent
from ai_agents.qa_coach_agent.test_autamation_feasibility_coach import AutomationFeasibilityCoachAgent
from ai_agents.qa_coach_agent.test_generation_coach import TestGenerationCoachAgent
from ai_agents.qa_coach_agent.test_step_audit_coach import AuditCoachAgent
from ai_agents.qa_coach_agent.test_step_implementation_generation_coach import StepImplementationGenerationCoachAgent
from ai_agents.qa_coverage_planner_agent.test_coverage_planner_agent import CoveragePlannerAgent
from ai_agents.qa_locator_generator_agent.locator_generator_agent import LocatorGeneratorAgent
from ai_agents.qa_requirements_router_agent.requirements_router_agent import RequirementsRouterAgent
from ai_agents.qa_test_fixer_agent.test_fixer_agent import TestFixerAgent
from ai_agents.qa_test_generator_agent.test_generator import TestGeneratorAgent
from ai_agents.core.utils import collect_raw_steps, mine_patterns_with_drain
from ai_agents.qa_test_step_generator_agent.test_step_generator import StepGeneratorAgent
from ai_agents.qa_test_step_generator_agent.test_step_reviewer import StepReviewAgent
from ai_agents.qa_test_step_generator_agent.test_step_skeleton_generator import StepSkeletonGeneratorAgent
from ai_agents.qa_test_step_generator_agent.joker import Joker
from utilities.web_driver import get_driver


class Orchestrator:
    def __init__(self, document: str = "") -> None:
        self.document = document
        self.model_slug = sanitize_model_tag_for_filename(get_agent_model("TestGeneratorAgent"))
        self.lessons_manager = LessonsLearnedManager()
        self.skill_loader = SkillLoader()
        self.project_root = Path.cwd()
        self.features_dir = self.project_root / "features"
        self.feature_files = discover_all_feature_files(
            str(self.features_dir),
            model_slug=self.model_slug,
        )

    def orchestrate(self):
        router_decision = self.requirement_analysis()
        self.test_generation(router_decision)
        self.automation_feasibility()
        self.audit()
        self.code_generation()

    # ------------------------------------------------------------------
    # PHASE 1: TEST GENERATION PHASE
    # Coach: test_generation_coach -> REGENERATE / GENERATE / SKIP
    # Loop: coverage_planner -> test_generator -> *.feature files -> DONE
    # ------------------------------------------------------------------
    def test_generation_phase(self, instruction: RouterDecision) -> None:
        print("🔄 Test Generation Phase...")
        # 1. Inspect input document & existing *.feature files via test_generation_coach
        # 2. For directives with action in {"GENERATE", "REGENERATE"}:
        #    - plan = self.run_skill("coverage_planner", {...})
        #    - generated = self.run_skill("test_generator", {...})
        #    - write/update *.feature files via your existing file writer helper
        # 3. For action == "SKIP": leave existing *.feature untouched
        # 4. Refresh discovered feature files before moving to Automation Feasibility
        print(f"📄 Found {len(instruction.extracted_sections)} distinct section(s) to process...")
        print("🔄 Phase 0: Planning Test Generation Pipeline...")
        print("    🤖 [Test Generation Coach Agent]: Evaluating requirements sections vs existing root feature files...")

        test_gen_coach = BaseAgent(
            skill_name="test_generation_coach",
            lessons_manager=self.lessons_manager,
            skill_loader=self.skill_loader,
        )
        coverage_planner = BaseAgent(
            skill_name="coverage_planner",
            lessons_manager=self.lessons_manager,
            skill_loader=self.skill_loader,
        )
        test_generator = BaseAgent(
            skill_name="test_generator",
            lessons_manager=self.lessons_manager,
            skill_loader=self.skill_loader,
        )

        try:
            existing_features_summary = get_section_summary(instruction.extracted_sections, self.model_slug)
            for index, section in enumerate(instruction.extracted_sections, 1):
                coach_response = test_gen_coach.invoke(
                    {
                        "requirements_doc": section.section_content,
                        "existing_features_summary": existing_features_summary,
                    }
                )
                directives_by_index = {
                    target.section_index: target
                    for target in coach_response.target_scope
                }
                directive = directives_by_index.get(index)

                # Fallback guard: skip if file exists and no explicit re-generation is requested
                if not directive or directive.action == "SKIP":
                    print(
                        f"    ⏩ [Coach Directive] SKIP [{index}/{len(instruction.extracted_sections)}]: {section.section_title}"
                    )
                    continue

                print(
                    f"    🎯 [Coach Directive]: {directive.action} [{index}/{len(instruction.extracted_sections)}]: {section.section_title}"
                )
                print(f"    📋 Reason: {directive.reason}")

                # Trigger Coverage Planner & Test Generator ONLY for this specific section
                feature_suite = self.generate_tests(
                    section=section.section_content,
                    first_line=section.section_title,
                    coverage_planner=coverage_planner,
                    test_generator=test_generator,
                )

                # Write FeatureSuite to disk
                file_path = Path("features") / directive.feature_file_name
                file_path.parent.mkdir(parents=True, exist_ok=True)
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
        finally:
            del test_gen_coach, coverage_planner, test_generator
            gc.collect()

    # ------------------------------------------------------------------
    # PHASE 2: AUTOMATION FEASIBILITY PHASE
    # Coach: feasibility_coach -> RE-EVALUATE / EVALUATE / SKIP
    # Loop: behave -dry-run -> drain3 engine -> automation_feasibility
    # Output: *_feasibility_feedback.json -> DONE
    # ------------------------------------------------------------------
    def automation_feasibility_phase(self) -> None:
        print("🔄 Automation Feasibility Phase...")
        # 1. Audit feature / *_feasibility_feedback.json pairs via feasibility_coach
        # 2. For targets with action in {"EVALUATE", "RE-EVALUATE"}:
        #    - run your existing `behave --dry-run` + `drain3` step/pattern prep helpers
        #    - call self.run_skill("automation_feasibility", {...})
        #    - save updated *_feasibility_feedback.json via your existing helper
        # 3. For action == "SKIP": keep existing feedback report

    # ------------------------------------------------------------------
    # PHASE 3: AUDIT PHASE
    # Coach: audit_coach -> AUDIT / SKIP
    # Loop: pattern_audit -> pattern_parameter_resolution -> test_analyzer / test_modifier
    # Output: resolved_pattern in *_feasibility_feedback.json + updated *.feature -> DONE
    # ------------------------------------------------------------------
    def audit_phase(self) -> None:
        print("🔄 Audit Phase...")
        # 1. Inspect feedback payloads via audit_coach
        # 2. For targets with action == "AUDIT":
        #    - audit_res = self.run_skill("pattern_audit", {...})
        #    - resolved = self.run_skill("pattern_parameter_resolution", {...})
        #    - run your deterministic remediation / test_analyzer / test_modifier helpers
        #    - persist resolved_pattern to *_feasibility_feedback.json & update *.feature
        # 3. For action == "SKIP": skip audit remediation for that file

    # ------------------------------------------------------------------
    # PHASE 4: CODE GENERATION PHASE
    # Coach: code_generation_coach -> GENERATE / SKIP
    # Loop: test_step_skeleton_generator -> test_step_generator -> test_step_reviewer
    # Output: generated_by_ai_steps.py -> DONE
    # ------------------------------------------------------------------
    def code_generation_phase(self) -> None:
        print("🔄 Code Generation Phase...")
        # 1. Collect existing *_steps.py implementations + behave -dry-run status
        # 2. Audit via code_generation_coach -> per-step GENERATE / SKIP directives
        # 3. For steps with action == "GENERATE":
        #    - skeleton = self.run_skill("test_step_skeleton_generator", {...})
        #    - step_code = self.run_skill("test_step_generator", {...})
        #    - reviewed = self.run_skill("test_step_reviewer", {...})
        #    - write new step implementations to generated_by_ai_steps.py via your helper
        # 4. For action == "SKIP": leave existing step implementations untouched

    def requirement_analysis(self, payload: Optional[str] = None) -> RouterDecision:
        print("🔄 Phase 0: Requirement Analysis & Test Generation Pipeline...")
        raw_payload = payload if payload is not None else self.document

        router = BaseAgent(
            skill_name="requirements_router",
            lessons_manager=self.lessons_manager,
            skill_loader=self.skill_loader,
        )
        routing_decision: RouterDecision = router.invoke({"raw_payload": raw_payload})

        print(
            f"🔀 [Router Decision]: Detected {routing_decision.detected_format} "
            f"(Confidence: {routing_decision.confidence_score})"
        )
        print(f"💡 [Reasoning]: {routing_decision.reasoning}")

        del router
        gc.collect()
        return routing_decision

    @staticmethod
    @rest_check
    def generate_tests(section: str, first_line: str, coverage_planner: CoveragePlannerAgent,
                       test_generator: TestGeneratorAgent) -> FeatureSuite:
        try:
            print("        🤖 [Coverage Planner Agent]: Planning test scenario coverage matrix...")
            coverage_plan = coverage_planner.invoke(
                {
                    "requirement_text": section,
                    "requirement_section": first_line,
                }
            )
            print(f"            Planned {coverage_plan.total_scenarios_planned} test scenario(s).")

            # -----------------------------------------------------------------
            # PHASE 1: Generate Schema-Validated Gherkin FeatureSuite
            # -----------------------------------------------------------------
            print("        🤖 [Test Generator Agent]: Synthesizing Gherkin feature suite...")

            BATCH_SIZE = 2  # Small batch size to avoid output token limits
            all_scenarios = []
            feature_title = ""

            planned_scenarios = coverage_plan.scenarios
            total_scenarios = len(planned_scenarios)

            for i in range(0, total_scenarios, BATCH_SIZE):
                batch = planned_scenarios[i: i + BATCH_SIZE]

                # Create a temporary plan for this sub-batch
                batch_plan = coverage_plan.model_copy(update={"scenarios": batch})

                batch_suite = test_generator.invoke(
                    {
                     "coverage_plan": batch_plan,
                     "step_patterns": get_escaped_step_patterns(),
                     "business_knowledge": BUSINESS_KNOWLEDGE
                    }
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

    def test_generation(self, instruction: RouterDecision):
        print(f"📄 Found {len(instruction.extracted_sections)} distinct section(s) to process...")
        print("🔄 Phase 0: Planning Test Generation Pipeline...")
        print("    🤖 [Test Generation Coach Agent]: Evaluating requirements sections vs existing root feature files...")
        test_gen_coach = TestGenerationCoachAgent()
        coverage_planner = CoveragePlannerAgent()
        test_generator = TestGeneratorAgent()
        for index, section in enumerate(instruction.extracted_sections, 1):
            coach_response = test_gen_coach.evaluate_execution(
                requirements_doc=section.section_content,
                existing_features_summary=test_gen_coach.get_section_summary(instruction.extracted_sections,
                                                                             model_slug=self.model_slug)
            )
            directives_by_index = {target.section_index: target for target in coach_response.target_scope}
            directive = directives_by_index.get(index)

            # Fallback guard: skip if file exists and no explicit re-generation is requested
            if not directive or directive.action == "SKIP":
                print(
                    f"    ⏩ [Coach Directive] SKIP [{index}/{len(instruction.extracted_sections)}]: {section.section_title}")
                continue

            print(
                f"    🎯 [Coach Directive]: {directive.action} [{index}/{len(instruction.extracted_sections)}]: {section.section_title}")
            print(f"    📋 Reason: {directive.reason}")

            # Trigger Coverage Planner & Test Generator ONLY for this specific section
            feature_suite = self.generate_tests(
                section=section.section_content,
                first_line=section.section_title,
                coverage_planner=coverage_planner,
                test_generator=test_generator
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
        del test_gen_coach, coverage_planner, test_generator
        gc.collect()

    def automation_feasibility(self):
        print("🔄 Phase 1: Automation Feasibility & Pattern Mining Pipeline...")
        print("    🤖 [Feasibility Coach]: Evaluating feature feasibility status...")
        feasibility_coach = AutomationFeasibilityCoachAgent()
        feasibility_agent = AutomationFeasibilityAgent()
        feasibility_coach_response = feasibility_coach.evaluate_execution()
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
                    feasibility_agent.process_feature_file(str(feature_file), registry)
                else:
                    print(f"    ⏩ [Coach Directive] SKIP -> {feature_file.name} (Feedback intact)")
        else:
            print("    ⏩ [Feasibility Coach]: All feasibility feedback reports are valid and up to date.")
        del feasibility_coach, feasibility_agent
        gc.collect()

    def audit(self):
        print("🔄 Phase 2: Audit Pipeline...")
        print("    🔍 Phase 2.1: Harvesting known patterns from existing feedback JSON files...")
        harvested_patterns = PatternRegistry.collect_all_used_patterns(feedback_dir="features")
        pattern_registry = PatternRegistry(initial_patterns=harvested_patterns)
        print(f"    📋 PatternRegistry loaded with {len(pattern_registry.active_patterns)} unique active patterns.")
        print("    🤖 [Audit Coach]: Evaluating audit execution scope...")
        audit_coach = AuditCoachAgent(lessons_manager=self.lessons_manager)
        pattern_auditor = PatternAuditAgent()
        audit_coach_response = audit_coach.evaluate_audit_execution()
        feasibility_agent = AutomationFeasibilityAgent()
        audit_directives_map = {target.feature_file_name: target for target in audit_coach_response.target_scope}
        if audit_coach_response.should_run_audit:
            features_dir = Path("features")
            root_feature_files = [f for f in features_dir.glob("*.feature") if f.is_file()]
            for feature_file in root_feature_files:
                directive = audit_directives_map.get(feature_file.name)
                if directive and directive.action == "EXECUTE_AUDIT":
                    print(f"    🎯 [Coach Directive]: EXECUTE_AUDIT -> {feature_file.name}")
                    print(f"    📋 Reason: {directive.reason}")
                    pattern_auditor.audit_and_remediate_feature(
                        feature_path=str(feature_file),
                        registry=pattern_registry,
                        rematch_fn=feasibility_agent.rematch_step,
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
                else:
                    print(f"    ⏩ [Coach Directive]: SKIP_AUDIT -> {feature_file.name} (All resolved_patterns intact)")
        else:
            print("    ⏩ [Audit Coach]: All feedback files have complete, valid resolved_patterns.")
        del pattern_auditor, feasibility_agent, audit_coach, resolution_agent, test_fixer_agent
        gc.collect()

    def code_generation(self):
        print("🔄 Phase 3: Evaluating Step Definition & Code Generation Pipeline...")
        step_impl_coach = StepImplementationGenerationCoachAgent(lessons_manager=self.lessons_manager)
        skeleton_agent = StepSkeletonGeneratorAgent()
        step_generator_agent = StepGeneratorAgent()
        step_reviewer_agent = StepReviewAgent()

        output_file = Path("features/steps/generated_by_ai_steps.py")
        output_file.parent.mkdir(parents=True, exist_ok=True)
        if not output_file.exists():
            output_file.write_text("# Auto-generated steps\n", encoding="utf-8")

        # 1. Audit step status via behave dry-run
        step_status = audit_steps_via_behave(self.feature_files)

        # Extract existing code for coach review
        existing_step_files = list(Path("features/steps").glob("*.py"))
        existing_step_definitions = [f.read_text(encoding="utf-8") for f in existing_step_files]

        # 2. Invoke Step Implementation Coach
        coach_response = step_impl_coach.evaluate_execution(
            step_status_report=step_status,
            existing_step_definitions=existing_step_definitions
        )
        gc.collect()

        if not coach_response.should_run_generator or not coach_response.target_scope:
            print("⏩ [Audit Coach]: All step definitions are clean and valid. Skipping generation.")
            return True

        print("🤖 [Audit Coach]: Processing actions in target scope...")

        has_changes = False

        for target in coach_response.target_scope:
            action = target.action
            pattern = target.step_pattern

            if action == "REMOVE":
                content = output_file.read_text(encoding="utf-8")
                blocks = content.split("\n@step")
                cleaned_blocks = []

                for i, block in enumerate(blocks):
                    block_text = "@step" + block if i > 0 else block

                    # Check if the block contains the hardcoded pattern to remove
                    if f"('{pattern}')" in block_text or f'("{pattern}")' in block_text:
                        print(f"🗑️ Removing hardcoded/redundant step definition block for: '{pattern}'")
                        has_changes = True
                        continue

                    cleaned_blocks.append(block_text)

                if has_changes:
                    output_file.write_text("\n".join(cleaned_blocks), encoding="utf-8")
                    print(f"✅ Cleaned up file: {output_file}")

            elif action == "GENERATE":
                print(f"🔍 Phase 3.1: Generating balanced step for pattern: '{pattern}'")

                # Pass single pattern to generator enforce balanced structure
                skeletons = skeleton_agent.generate_skeletons({pattern}, [pattern])
                if skeletons:
                    draft_code = step_generator_agent.generate_missing_steps("\n\n".join(skeletons))
                    cleaned_code = step_reviewer_agent.review_and_fix(draft_code)

                    with open(output_file, "a", encoding="utf-8") as out_f:
                        out_f.write("\n\n" + cleaned_code + "\n")

                    print(f"✅ Appended new balanced step definition for '{pattern}' to {output_file}")
                    has_changes = True

            elif action == "REFACTOR":
                print(f"🔧 Refactoring step definition for pattern: '{pattern}'...")
                # Handled by refactoring agent or targeted block rewrite
                pass
        del step_impl_coach, skeleton_agent, step_generator_agent, step_reviewer_agent
        gc.collect()
        return has_changes

    @staticmethod
    def locator_generation():
        print("🔄 Phase 4: Locator Generation Pipeline...")
        locator_generator_agent = LocatorGeneratorAgent()
        scenarios = parse_feature_files()
        all_locators = []
        for scenario in scenarios:
            print(f"    🔍 Phase 4.1: Generating locators for scenario: {scenario['title']}")
            login_to_app(get_driver("chrome"))
            elements = harvest_page_elements(get_driver("chrome"), scenario['page_url'])
            locators = locator_generator_agent.generate_locators(scenario["raw_text"], elements)
            all_locators.extend(locators.sections)
        save_all_locators_to_ini(all_locators, output_dir="elements", file_name="generated_by_ai_locators.ini")
        print("    ✅ Generated locators:")
        del locator_generator_agent
        gc.collect()

    @staticmethod
    def page_locators(dom_candidates: List[dict]):
        locator_generator_agent = LocatorGeneratorAgent()
        return locator_generator_agent.filter_navigation_elements(dom_candidates)

    @staticmethod
    def optimize_tests():
        print("🔄 Phase 5: Optimizing Gherkin Feature File Syntax...")

        # 1. Locate all feature files in your features directory
        features_dir = Path("features")
        if not features_dir.exists():
            print("❌ Features directory not found!")
            return

        feature_files = list(features_dir.glob("*.feature"))
        if not feature_files:
            print("⚠️ No .feature files found to optimize.")
            return

        # 2. Automatically scan and aggregate all step implementations from features/steps/
        existing_step_implementations = get_step_patterns()

        # 3. Instantiate the Joker agent once outside the loop to save overhead
        joker_agent = Joker()

        try:
            for file_path in feature_files:
                print(f"📄 Processing feature file: {file_path.name}")

                # Read the current content of the feature file
                feature_content = file_path.read_text(encoding="utf-8")

                # Optimize/harmonize the feature content via the agent
                optimized_feature_content = joker_agent.optimize_test_doc(
                    existing_step_implementations=existing_step_implementations,
                    feature_content=feature_content
                )

                # Overwrite the feature file with the synchronized syntax
                file_path.write_text(optimized_feature_content, encoding="utf-8")
                print(f"✅ Successfully optimized and saved: {file_path.name}")

        finally:
            # Clean up memory safely
            del joker_agent
            gc.collect()
            print("🧹 Joker agent memory cleaned up.")

    @staticmethod
    def optimize_step_implementation():
        print("🔄 Optimizing step implementations pattern by pattern...")

        # 1. Load framework utilities once
        framework_utilities = load_framework_utilities()

        # 2. Get all patterns (assuming get_step_patterns() returns a list or iterable of strings)
        step_patterns = get_step_patterns()

        if not step_patterns:
            print("⚠️ No step patterns found to optimize.")
            return
        list_step_patterns = [
            line.strip()
            for line in step_patterns.splitlines()
            if line.strip().startswith(("@given", "@when", "@then", "@step"))
        ]
        print(f"📂 Found {len(list_step_patterns)} step pattern(s) to process.")

        joker_agent = Joker()
        all_generated_implementations = []

        try:
            for index, pattern in enumerate(list_step_patterns, 1):
                print(f"\n[{index}/{len(list_step_patterns)}] Processing pattern: '{pattern}'")

                try:
                    # Process one pattern at a time
                    optimized_code = joker_agent.optimize_step_implementation(
                        framework_utilities=framework_utilities,
                        step_pattern=pattern
                    )
                    all_generated_implementations.append(optimized_code)
                    print(f"✅ Generated implementation for pattern {index}.")
                except Exception as e:
                    print(f"❌ Error generating step for '{pattern}': {e}")

            # Combine all generated step implementations into a final string/file
            final_code = "\n\n".join(all_generated_implementations)
            print("\n🎉 All step implementations generated successfully!")
            output_file = Path("features/steps/generated_by_ai_steps.py")
            output_file.parent.mkdir(parents=True, exist_ok=True)
            with open(output_file, "w", encoding="utf-8") as out_f:
                output_file.write_text("# Auto-generated steps\n", encoding="utf-8")
                out_f.write("from utilities.step_helper import step")
                out_f.write("\n\n" + final_code + "\n")
        finally:
            del joker_agent
            gc.collect()
            print("🧹 Joker agent memory cleaned up after full batch optimization.")
