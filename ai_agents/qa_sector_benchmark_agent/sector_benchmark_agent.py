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
from datetime import datetime, timezone
from pathlib import Path
from typing import Optional

import requests
from bs4 import BeautifulSoup
from langchain_core.prompts import PromptTemplate

from ai_agents.core.base_agent import BaseAgent
from ai_agents.core.schemas import SectorInsightsPayload

INSIGHT_EXTRACTION_PROMPT = """You are an expert Safety-Critical QA and BDD Automation Benchmark Analyst specializing in automotive (ISO 26262) and aerospace (DO-178C) testing standards.
Analyze the following scraped text from a discovered testing website and extract structured insights, news, or standards updates.

Source URL: {url}

Scraped Content:
{raw_text}

Extract the key testing insights according to the requested schema. Ensure technical accuracy and focus on actionable takeaways for test automation frameworks.
"""


class SectorBenchmarkAgent(BaseAgent):
    def __init__(
            self,
            insights_json_path: str = "ai_agents/core/qa_sector_insights.json",
            discovered_sites_path: str = "ai_agents/core/discovered_sites.json",
            **kwargs
    ):
        super().__init__(temperature=0.2, **kwargs)

        self.insights_json_path = Path(insights_json_path)
        self.discovered_json_path = Path(discovered_sites_path)

        # Extraction Chain: Maps raw scraped content into structured insights using Pydantic
        self.extraction_chain = (
                PromptTemplate.from_template(INSIGHT_EXTRACTION_PROMPT)
                | self.llm.with_structured_output(SectorInsightsPayload)
        )

        print(f"✅ SectorBenchmarkAgent initialized.")
        print(f"   - Discovered Sites Source: {self.discovered_json_path}")
        print(f"   - Insights Output Target: {self.insights_json_path}")

    def load_discovered_sites(self) -> list[dict]:
        """Loads verified URLs from discovered_sites.json."""
        if not self.discovered_json_path.exists():
            print(f"⚠️ Warning: {self.discovered_json_path.name} not found. Run ResearchDiscoveryAgent first.")
            return []

        try:
            content = self.discovered_json_path.read_text(encoding="utf-8")
            data = json.loads(content)
            return data
        except Exception as e:
            print(f"❌ Error loading discovered sites: {e}")
            return []

    def scrape_url(self, url: str) -> Optional[str]:
        """Performs content scraping and text extraction on a target URL."""
        headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) QA-Automator/1.0"}
        try:
            response = requests.get(url, headers=headers, timeout=10)
            if response.status_code == 200:
                soup = BeautifulSoup(response.text, "html.parser")

                # Strip out clutter tags
                for script in soup(["script", "style", "nav", "footer", "header"]):
                    script.decompose()

                text = soup.get_text(separator=" ", strip=True)
                return text[:8000]  # Token window guardrail for the LLM
            else:
                print(f"⚠️ Failed to fetch {url} - Status Code: {response.status_code}")
        except Exception as e:
            print(f"❌ Scraping exception for {url}: {e}")
        return None

    def start_benchmark(self):
        """Executes the full Harvester & Evaluator cycle using the LangChain chain."""
        sites = self.load_discovered_sites()
        if not sites:
            print("📭 No sites found to process.")
            return

        existing_insights = []
        if self.insights_json_path.exists():
            try:
                existing_data = json.loads(self.insights_json_path.read_text(encoding="utf-8"))
                existing_insights = existing_data.get("insights", [])
            except Exception:
                existing_insights = []

        new_count = 0
        for site in sites:
            url = site.get("url") if isinstance(site, dict) else getattr(site, "url", None)
            if not url:
                continue

            print(f"🔍 Harvester diving into: {url}")
            raw_text = self.scrape_url(url)

            if raw_text:
                try:
                    # Invoke the LLM chain with structured output
                    result = self.extraction_chain.invoke({
                        "url": url,
                        "raw_text": raw_text
                    })

                    for insight in result.insights:
                        record = insight.model_dump() if hasattr(insight, 'model_dump') else insight.dict()
                        record["insight_id"] = "TempID"
                        record["source_url"] = url
                        record["harvested_at"] = datetime.now(timezone.utc).isoformat().replace("+00:00", "Z")

                        existing_insights.append(record)
                        new_count += 1
                except Exception as e:
                    print(f"❌ Chain extraction error for {url}: {e}")

        # Save down to qa_sector_insights.json
        self.insights_json_path.parent.mkdir(parents=True, exist_ok=True)
        output_payload = {
            "last_updated": datetime.utcnow().isoformat() + "Z",
            "total_insights": len(existing_insights),
            "insights": existing_insights
        }

        self.insights_json_path.write_text(json.dumps(output_payload, indent=2, ensure_ascii=False), encoding="utf-8")
        print(f"✅ Successfully added {new_count} new insight(s) to {self.insights_json_path.name}")
