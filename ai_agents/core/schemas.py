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

from enum import Enum
from typing import List, Dict, Any, Literal, Optional
from pydantic import BaseModel, Field


# ==========================================
# 1. COVERAGE PLANNER AGENT SCHEMAS
# ==========================================

class ScenarioType(str, Enum):
    HAPPY_PATH = "HAPPY_PATH"
    NEGATIVE = "NEGATIVE"
    BOUNDARY_EDGE_CASE = "BOUNDARY_EDGE_CASE"
    SECURITY_AUTH = "SECURITY_AUTH"


class TestScenarioPlan(BaseModel):
    scenario_id: str = Field(description="Unique scenario identifier, e.g., SCENARIO_01")
    title: str = Field(description="Clear title of the test scenario")
    type: ScenarioType = Field(description="Category of the test scenario")
    objective: str = Field(
        description="Brief explanation of what business rule or acceptance criteria is being verified")
    tag: str = Field(description="CamelCase tag without spaces, e.g., @LoginSuccess, @InsufficientBalance")


class CoveragePlan(BaseModel):
    requirement_section: str = Field(description="Title or section name of the analyzed business requirement")
    total_scenarios_planned: int = Field(description="Total count of scenarios generated")
    scenarios: List[TestScenarioPlan] = Field(description="List of planned test scenarios")


# ==========================================
# 2. FEATURE & CODE GENERATOR SCHEMAS
# ==========================================

class BDDStep(BaseModel):
    keyword: str = Field(description="Given, And, When, or Then")
    statement: str = Field(
        description="Step statement using syntax like 'I open \"...\"', 'I enter \"...\" into Field field', 'I see \"...\" as Field field value'"
    )


class ScenarioItem(BaseModel):
    tag: str = Field(description="CamelCase tag without spaces, e.g., @Register, @LoginSuccess, @ABNPrompt")
    name: str = Field(description="Clear title of the scenario")
    steps: List[BDDStep]


class FeatureSuite(BaseModel):
    feature_title: str = Field(default="Web Automation with Behave", description="Title of the feature suite")
    scenarios: List[ScenarioItem]


# ==========================================
# 2.1. LOCATOR AND ELEMENT EXTRACTION SCHEMAS
# ==========================================

class ActionType(str, Enum):
    NAVIGATE = "NAVIGATE"
    INPUT = "INPUT"
    CLICK = "CLICK"
    SELECT = "SELECT"
    VERIFY = "VERIFY"


class LocatorSection(BaseModel):
    section_name: str = Field(description="The section or page header, e.g., 'Home Page', 'Test Login Page'")
    locators: Dict[str, str] = Field(description="Dictionary mapping element keys to their locator strings, e.g., {'Username': '//*[@id=\'username\']'}")


class LocatorFileSchema(BaseModel):
    sections: List[LocatorSection] = Field(description="List of all locator sections mapped across pages.")


# ==========================================
# 3. PATTERN AUDIT AGENT SCHEMAS
# ==========================================

class StepAuditItem(BaseModel):
    step_text: str = Field(description="Exact step_text from the audited scenario input")
    assigned_pattern: str = Field(description="Exact assigned_pattern from input evaluated against step_text")
    status: Literal["valid", "mismatch"] = Field(
        description="'mismatch' if verbs, meaning, or structure disagree; otherwise 'valid'")
    root_cause: str = Field(default="", description="Detailed explanation if status is mismatch; empty string if valid")


class PatternAuditResponse(BaseModel):
    has_mismatches: bool = Field(description="True if any step item in audit_results has status 'mismatch'")
    audit_results: List[StepAuditItem] = Field(default_factory=list,
                                               description="List of step-to-pattern audit evaluations")


# ==========================================
# 4. COACH AGENT SCHEMAS
# ==========================================

class FeatureTargetScope(BaseModel):
    section_index: int = Field(description="The 1-based index of the requirement section, e.g., 1")
    section_title: str = Field(description="Title of the requirement section, e.g., '1. Create a New Account'")
    feature_file_name: str = Field(description="Target .feature file name, e.g., '01_create_a_new_account.feature'")
    action: Literal["GENERATE", "REGENERATE", "SKIP"] = Field(description="Action directive for the section")
    reason: str = Field(description="Justification based on requirement coverage or historical failure modes")
    lessons_for_agent: List[str] = Field(default_factory=list,
                                         description="Failure modes or rules to pass to TestGeneratorAgent")


class TestGenerationCoachResponse(BaseModel):
    should_run_generator: bool = Field(description="True if at least one feature needs generation or re-generation")
    target_scope: List[FeatureTargetScope] = Field(default_factory=list,
                                                   description="List of feature targets and their directives")


class FeasibilityTargetScope(BaseModel):
    feature_file_name: str = Field(description="Name of the .feature file")
    feedback_file_name: str = Field(description="Name of the feasibility feedback JSON file")
    action: Literal["EVALUATE", "RE_EVALUATE", "SKIP"] = Field(description="Directive action for FeasibilityAgent")
    reason: str = Field(description="Reason for decision taking lessons_learned and status into account")


class AutomationFeasibilityCoachResponse(BaseModel):
    should_run_feasibility: bool = Field(description="True if at least one feature needs EVALUATE or RE_EVALUATE")
    target_scope: List[FeasibilityTargetScope] = Field(
        description="MUST contain an entry for EVERY feature where feedback_exists is false or re-evaluation is needed")
    should_harvest_patterns: bool = Field(default=True)


class AuditCoachTargetScope(BaseModel):
    feature_file_name: str
    feedback_file_name: str
    action: Literal["EXECUTE_AUDIT", "SKIP_AUDIT"]
    unresolved_step_count: int = Field(default=0, description="Count of steps missing valid resolved_pattern")
    reason: str = Field(description="Detailed explanation for why audit is required or skipped")


class AuditCoachResponse(BaseModel):
    target_scope: List[AuditCoachTargetScope]
    should_run_audit: bool


class StepImplementationTargetScope(BaseModel):
    step_pattern: str = Field(
        description="The Gherkin step pattern requiring implementation, e.g., 'I click on {element}'"
    )
    action: Literal["GENERATE", "SKIP", "REMOVE", "REFACTOR"] = Field(
        description="Directive action for step definition code generation"
    )
    target_python_file: Optional[str] = Field(
        default="features/steps/generated_by_ai_steps.py",
        description="Target Python file where the step definition code should be written or updated"
    )
    reason: str = Field(
        description="Detailed explanation for the directive based on undefined steps or existing step definitions"
    )


class StepImplementationCoachResponse(BaseModel):
    should_run_generator: bool = Field(
        description="True if at least one undefined step pattern requires GENERATE_NEW"
    )
    target_scope: List[StepImplementationTargetScope] = Field(
        default_factory=list,
        description="List of undefined step targets and their implementation directives"
    )


class SearchQueries(BaseModel):
    queries: List[str] = Field(description="List of 3 to 5 targeted search query strings")


class DiscoveredURL(BaseModel):
    url: str = Field(description="Verified URL selected from search results")
    site_type: str = Field(description="e.g., 'Company Engineering Blog', 'Official Documentation'")
    reason: str = Field(description="Brief explanation of why this target is useful")


class DiscoveryPayload(BaseModel):
    discovered_sites: List[DiscoveredURL] = Field(description="Filtered list of useful target URLs")


class TechStackInsight(BaseModel):
    category: str = Field(
        description="Category, e.g., 'BDD Automation', 'Self-Healing Locators', 'Performance & Load', 'AI Testing Patterns'"
    )
    technology_or_pattern: str = Field(
        description="Name of the technology, library, framework, or architectural pattern"
    )
    summary: str = Field(
        description="Brief explanation of how this technology/pattern improves testing efficiency or code quality"
    )
    prompt_injection_rule: str = Field(
        description="A concise, actionable directive rule to inject into generator agent prompts (e.g., 'Prefer play-based async waiting over fixed explicit sleeps')"
    )


class SectorInsight(BaseModel):
    insight_id: str = Field(description="Unique identifier or UUID for the extracted insight.")
    title: str = Field(description="Headline or title of the scraped resource or standard update.")
    category: str = Field(
        description="Category such as Automotive (ISO 26262), Aerospace (DO-178C), BDD Automation, or Tool Update.")
    summary: str = Field(description="Concise summary of what happened or what new testing practice was introduced.")
    key_takeaways: List[str] = Field(description="Specific technical rules, requirements, or benchmarks extracted.")
    actionable_impact: str = Field(
        description="How this affects our automation framework or whether it requires new test scenarios.")
    relevance_score: float = Field(
        description="Relevance score between 0.0 and 1.0 evaluating value for high-reliability QA.")


class SectorInsightsPayload(BaseModel):
    insights: List[SectorInsight] = Field(description="List of extracted testing sector insights.")
