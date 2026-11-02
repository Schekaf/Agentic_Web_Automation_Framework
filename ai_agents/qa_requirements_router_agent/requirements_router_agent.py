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
from langchain_core.prompts import PromptTemplate

from ai_agents.core.base_agent import BaseAgent
from ai_agents.core.schemas import RouterDecision
from ai_agents.core.utils import rest_check

PROMPT = """You are an expert AI Test Automation Architect specializing in document parsing, requirements analysis, and routing.

YOUR TASK:
Inspect the provided input payload structure, determine its format, and if it is an unstructured or custom document, **categorize and split it into logical requirement sections**.

INPUT PAYLOAD:
{raw_payload}

ROUTING & CATEGORIZATION RULES:
1. **Jira/Xray Test Steps:** If the input contains structured manual test steps -> route to 'XrayToGherkinAgent'.
2. **BRD/SRS/User Stories:** If the input is a well-structured Business Analysis Document -> route to 'CoveragePlannerAgent'.
3. **Custom / Unstructured Documents:** If the input does not match standard formats, set target_agent to 'DynamicSectionProcessor' and detected_format to 'CUSTOM_UNSTRUCTURED_DOC'. Then, **actively parse the text**, break it down into logical functional sections, give each section a clean title, a short snake_case feature file name, and extract its relevant content.

Rigidly adhere to the response schema output format.
"""


class RequirementsRouterAgent(BaseAgent):
    """
    Phase 0 Agent: Inspects raw input payloads (JSON, Markdown, text files, Jira exports)
    and routes them to the correct downstream agent (XrayToGherkinAgent or CoveragePlannerAgent).
    """

    def __init__(self, **kwargs):
        # 1. Delegate LLM, model, and lessons_manager setup to BaseAgent
        super().__init__(temperature=0.0, format_json=True, **kwargs)

        # 2. Build structured output chain matching your standard pattern
        prompt = PromptTemplate.from_template(PROMPT)
        self.chain = prompt | self.llm.with_structured_output(RouterDecision)

    @rest_check
    def route_payload(self, raw_payload: str) -> RouterDecision:
        """
        Invokes the agent chain to classify and route the input payload.
        """
        result = self.chain.invoke({
            "raw_payload": raw_payload
        })

        return result
