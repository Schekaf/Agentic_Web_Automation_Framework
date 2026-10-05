import json
from pathlib import Path

import requests
from langchain_core.prompts import PromptTemplate

from ai_agents.core.base_agent import BaseAgent
from ai_agents.core.schemas import DiscoveryPayload

SCOUT_PROMPT = """You are the Research Discovery Agent (Scout Agent).
Your job is to dynamically discover, evaluate, and output high-quality web resources for software testing benchmarks, tools, and practices across the global QA ecosystem.

LESSONS LEARNED: 
{lessons_learned}

STRICT URL & DISCOVERY CONSTRAINTS:
1. Do NOT guess subdomains or construct unverified deep links.
2. Only output verified root URLs or official documentation index paths.
3. Focus on actionable technical value (architecture patterns, framework benchmarks, case studies, and compliance guidelines).

FOCUS AREA: {focus_area}

ALREADY DISCOVERED / KNOWN SITES (DO NOT REPEAT THESE):
{already_discovered_json}

DYNAMIC DISCOVERY HORIZONS & STRATEGY:

Horizon 1: Global QA & Enterprise Tech Companies
Search and discover IT/QA service providers, testing consultancies, and tech giants with dedicated engineering blogs.
Structure search queries by regional hubs and domain verticals:
- Turkey: Search local IT/QA service providers and defense/automotive software engineering firms (e.g., Testinium, TesterYou, HAVELSAN, BAYKAR).
- Europe: Search automotive ECU/HIL testing firms, consultancies, and OEMs (e.g., Vector Informatik, dSPACE, Capgemini, BMW/Airbus software engineering).
- Americas: Search enterprise QA providers, Big Tech engineering portals, and defense/aerospace (e.g., Google, Tesla, SmartBear, Tricentis, Boeing).
- Asia-Pacific (Japan, China, etc.): Search autonomous driving QA, telecom, and robotics test platforms (e.g., Toyota Connected, Baidu Apollo, NTT DATA).

Horizon 2: Communities & Knowledge Aggregators
Search for platforms where QA engineers actively discuss methodologies, shift-left testing, and test architecture:
- Dedicated QA Hubs: Ministry of Testing, TestGuild, Atlassian Xray / TestRail guides.
- Engineering Blogs & Developer Publications: Medium (#software-testing, #bdd), Dev.to, LinkedIn Articles, GitHub Topic Pages, StackOverflow tags.
- Academic & Compliance Standards: IEEE Xplore, ISO 26262 V&V guides, DO-178C avionics standards documentation.

Horizon 3: Frameworks, Packages & Tools Analysis
Discover and evaluate testing tools across Python, Web, Mobile, API, Performance, and Automotive/Embedded QA.
For every discovered framework or package, gather:
- Purpose & Domain Focus (e.g., BDD, API performance, HIL simulation, UI automation).
- Good sides / Strengths (e.g., parallel execution, self-healing locators, CI/CD integration).
- Bad sides / Limitations (e.g., setup complexity, flakiness, steep learning curve).

TARGET CRITERIA:
1. Official framework and library documentation portals (e.g., Behave, Pytest, Selenium, Playwright, k6, Appium).
2. Major tech company engineering blogs sharing QA benchmarks and infrastructure case studies.
3. High-value community articles, whitepapers, and standards guides that help improve test automation frameworks.

OUTPUT: Return a list of targeted URLs matching the criteria.
"""
AUTOMOTIVE_AVIATION_FOCUS_AREA = """
Automotive and Aviation Industry Software Testing & QA Practices:
1. High-reliability web/UI test automation frameworks (Python, Behave BDD, Selenium, Pytest, Playwrite).
2. Safety-critical test design patterns, zero-flakiness wait strategies, and strict assertion handling.
3. Test traceability, log pattern analysis (e.g., Drain3 log mining), and continuous integration pipelines in aerospace/automotive QA.
4. Modern engineering blogs from leading automotive OEMs (e.g., Mercedes-Benz, BMW, Porsche) and aerospace companies (e.g., Airbus, Boeing, Turkish Airlines).
"""


class ResearchDiscoveryAgent(BaseAgent):
    def __init__(self, json_path: str = "ai_agents/core/discovered_sites.json", **kwargs):
        super().__init__(temperature=0.2, **kwargs)
        self.json_path = Path(json_path)
        self.chain = PromptTemplate.from_template(SCOUT_PROMPT) | self.llm.with_structured_output(DiscoveryPayload)

    def _validate_sites(self, payload: DiscoveryPayload) -> DiscoveryPayload:
        """
        Validates reachability of discovered URLs via HTTP HEAD requests,
        filters out dead links, and logs lessons learned for hallucinated domains.
        """
        valid_sites = []
        headers = {
            "User-Agent": (
                "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
            )
        }
        existing_data = json.loads(self.json_path.read_text(encoding="utf-8")) if self.json_path.exists() else []
        for site in payload.discovered_sites:
            try:
                response = requests.head(
                    site.url, timeout=3, allow_redirects=True, headers=headers
                )
                if response.status_code < 400:
                    valid_sites.append(site)
                else:
                    self._record_broken_url_lesson(
                        site.url, f"HTTP {response.status_code}"
                    )
            except Exception as e:
                self._record_broken_url_lesson(site.url, str(e))

        payload.discovered_sites = valid_sites
        # Append new findings to the JSON store
        for site in valid_sites:
            site_dict = site.model_dump()
            if site_dict not in existing_data:
                existing_data.append(site_dict)
        self.json_path.parent.mkdir(parents=True, exist_ok=True)
        self.json_path.write_text(json.dumps(existing_data, indent=2), encoding="utf-8")
        return payload

    def _record_broken_url_lesson(self, url: str, reason: str) -> None:
        """
        Logs hallucinated or dead domains directly to LessonsManager using the structured schema.
        """
        self.lessons_manager.add_lesson(
            agent_id=self.agent_name,
            category="URL_REACHABILITY",
            original_output=f"Suggested URL: {url}",
            corrected_output="Remove dead link from target discovery list",
            root_cause=f"Domain unreachable or returned error: {reason}",
            rule_derived=f"DO NOT suggest broken URL or domain: {url}",
        )

    def discover_sites(self, focus_area: str = AUTOMOTIVE_AVIATION_FOCUS_AREA) -> DiscoveryPayload:
        already_discovered = self.json_path.read_text(encoding="utf-8") if self.json_path.exists() else "[]"
        response = self.invoke(self.chain, {
            "focus_area": focus_area,
            "already_discovered_json": already_discovered})
        return self._validate_sites(response)
