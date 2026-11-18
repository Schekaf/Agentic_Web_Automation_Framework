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
import json
from typing import List

from dotenv import load_dotenv
from langchain_core.prompts import PromptTemplate

from ai_agents.core.base_agent import BaseAgent
from ai_agents.core.schemas import LocatorFileSchema, \
    NavigationFilterOutput  # Assuming you defined this schema or similar
from ai_agents.core.utils import rest_check

load_dotenv()

PROMPT = """You are an expert AI Test Automation Engineer specializing in Selenium and robust locator strategies.

YOUR TASK:
Analyze the provided Gherkin scenario and the list of harvested DOM elements from the target page. For each interactive element, input field, button, or verification message referenced in the scenario, select the best matching element from the provided DOM candidates and generate a robust XPath or CSS locator.

GHERKIN SCENARIO:
{scenario_text}

HARVESTED DOM ELEMENTS (CANDIDATES):
{dom_candidates}

CRITICAL RULES FOR LOCATOR GENERATION:
1. **Exact Key Matching:** Use the exact element name or label referenced in the scenario as the key (e.g., `Register = //...`, `Username = //...`, `Address = //...`), NOT uppercase snake_case modifiers like REGISTER_BUTTON.
2. **Valid XPath Syntax:** XPaths MUST use lowercase tag names (e.g., `//div[...]`, `//input[...]`, `//button[...]`). NEVER use uppercase tags (`DIV`, `INPUT`) and NEVER prefix locators with `xpath=`.
3. **Deduplication:** Avoid generating duplicate keys within the same section.
4. Rigidly adhere to the response schema output format.
5. **Human-Readable Keys (NO SNAKE_CASE):** Use clean, natural Title Case keys matching how elements or fields are described in the scenario text (e.g., `Select Account A = ...`, `Job Title = ...`, `Username = ...`). **NEVER** use snake_case like `select_account_a` or uppercase snake_case like `REGISTER_BUTTON`.
"""

NAVIGATOR_FILTER_PROMPT = """
You are an expert QA automation navigation analyst. 
You are given a list of interactive elements harvested from a web application's homepage.

Your task is to identify ONLY the elements that act as navigation links, menu items, or dashboard cards that take the user to a new subpage/feature view (e.g., "Wings Exports", "Raw Orders", "Mail Intake", settings, or reports).

DO NOT select elements that are:
- Generic buttons like "Save", "Cancel", "Delete", "Submit", or "Log out".
- Form inputs or dropdown menus.
- Footer links, privacy policies, or help modals that don't change the main workspace view.

HARVESTED ELEMENTS:
{dom_candidates}

Return your response strictly as a JSON list of strings containing the exact text or identifiers of the navigation elements you chose.
"""


class LocatorGeneratorAgent(BaseAgent):
    """
    Phase 4 Agent: Takes a Gherkin scenario and harvested page DOM elements,
    then uses LLM reasoning to map them into robust, schema-validated locators.
    """

    def __init__(self, **kwargs):
        # 1. Delegate LLM, model, and lessons_manager setup to BaseAgent
        super().__init__(temperature=0.1, format_json=True, **kwargs)

        # 2. Build structured output chain
        prompt = PromptTemplate.from_template(PROMPT)
        self.chain = prompt | self.llm.with_structured_output(LocatorFileSchema)

        filter_promt = PromptTemplate.from_template(NAVIGATOR_FILTER_PROMPT)
        self.filter_chain = filter_promt | self.llm.with_structured_output(NavigationFilterOutput)

    @rest_check
    def generate_locators(self, scenario_text: str, dom_candidates: List[dict]) -> LocatorFileSchema:
        """
        Invokes the agent chain to generate mapped locators for a given scenario and page DOM.
        """

        # Invoke chain matching prompt parameters
        result = self.chain.invoke({
            "scenario_text": scenario_text,
            "dom_candidates": dom_candidates
        })

        return result

    @rest_check
    def filter_navigation_elements(self, dom_candidates: List[dict]) -> List[str]:
        """
        Given a list of harvested elements return the best matching locators which are pointing to a new subpage.
        """
        slim_candidates = [
            {
                "tag": el.get("tag_name"),
                "text": el.get("text_content"),
                "id": el.get("element_id"),
                "name": el.get("name"),
                "placeholder": el.get("placeholder"),
                "href": el.get("href"),
                "xpath": el.get("xpath_candidate")
            }
            for el in dom_candidates if el.get("text_content") or el.get("element_id")
        ]

        candidates_json_str = json.dumps(slim_candidates, indent=2)

        # 2. Invoke using your pre-built filter chain
        print("🤖 Analyzing page elements for navigation targets...")
        response = self.filter_chain.invoke({
            "dom_candidates": candidates_json_str
        })

        # 3. Map the LLM's selected identifiers back to the full original `dom_candidates` dictionaries
        filtered_identifiers = [item.element_xpath for item in response.navigators]


        print(
            f"🎯 Filtered {len(filtered_identifiers)} navigation targets out of {len(dom_candidates)} total harvested elements.")
        return filtered_identifiers