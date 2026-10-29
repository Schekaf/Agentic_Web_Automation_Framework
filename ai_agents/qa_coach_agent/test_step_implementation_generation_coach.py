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
from pathlib import Path
from typing import List, Dict, Any, Union, Set
import json
from langchain_core.prompts import PromptTemplate
from ai_agents.core.base_agent import BaseAgent
from ai_agents.core.schemas import StepImplementationCoachResponse

STEP_IMPLEMENTATION_COACH_PROMPT = """You are the intelligent Step Implementation Coach Agent responsible for auditing and gatekeeping Phase 4 code generation and refactoring.

EXISTING STEP DEFINITIONS CODEBASE:
{existing_step_definitions}

FEATURE SUITE AUDIT REPORT (STATUS & ISSUES):
{step_status_report}

YOUR TASK:
Analyze the feature suite audit report against the existing codebase. Determine which items require code generation (missing steps) or refactoring/resolution (ambiguous or conflicting steps).

RULES & DIRECTIVES:
1. **GENERATE**: Use for completely missing or undefined steps. Add the step pattern to `target_scope`.
2. **REMOVE**: Use for ambiguous or conflicting steps (e.g., `AmbiguousStep` errors where multiple decorators clash). Add the conflicting pattern or error context to `target_scope`.
3. **SKIP**: Use for steps that are already uniquely and correctly implemented.

CRITICAL INSTRUCTION:
For EVERY item in the audit report that requires action (GENERATE or REFACTOR), you MUST include it in `target_scope`. 
Set `should_run_generator=True` if `target_scope` is not empty, otherwise `should_run_generator=False`.
"""


class StepImplementationGenerationCoachAgent(BaseAgent):
    """
    Supervisory Coach Agent that evaluates undefined Gherkin step patterns
    against existing step definitions before triggering Python code generation.
    """

    def __init__(self, **kwargs):
        super().__init__(temperature=0.0, **kwargs)

        prompt = PromptTemplate.from_template(STEP_IMPLEMENTATION_COACH_PROMPT)
        self.chain = prompt | self.llm.with_structured_output(StepImplementationCoachResponse)

    def evaluate_execution(
        self,
        existing_step_definitions: List[str],
        step_status_report: List[dict]
    ) -> StepImplementationCoachResponse:
        """
        Evaluates gate criteria for Phase 4 step code generation based on undefined steps.
        """
        try:
            if not step_status_report:
                return StepImplementationCoachResponse(
                    should_run_generator=False,
                    target_scope=[]
                )

            coach_response: StepImplementationCoachResponse = self.invoke(
                self.chain,
                {
                    "step_status_report": json.dumps(step_status_report, indent=2, ensure_ascii=False),
                    "existing_step_definitions": json.dumps(existing_step_definitions, indent=2, ensure_ascii=False)
                }
            )
            return coach_response
        except Exception as e:
            print(f"   ⚠️ [StepImplementationGenerationCoachAgent] Scope analysis error: {e}")
            return StepImplementationCoachResponse(
                should_run_generator=True,
                target_scope=[]
            )