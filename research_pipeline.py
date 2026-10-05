import sys

from ai_agents.qa_sector_benchmark_agent.research_discovery_agent import ResearchDiscoveryAgent


def print_discovery_results(discovery_results) -> None:
    """
    Formats and prints the Research Discovery Agent's TargetSite payload cleanly to the console.
    """
    sites = getattr(discovery_results, "discovered_sites", [])

    print("\n" + "=" * 80)
    print(f"🌐 RESEARCH DISCOVERY RESULTS (Found {len(sites)} Target Sites)")
    print("=" * 80 + "\n")

    if not sites:
        print("⚠️ No target sites found.")
        return

    for idx, site in enumerate(sites, start=1):
        # Handles both Pydantic models (site.url) and standard dictionaries
        url = getattr(site, "url", site.get("url") if isinstance(site, dict) else "N/A")
        site_type = getattr(site, "site_type", site.get("site_type") if isinstance(site, dict) else "N/A")
        reason = getattr(site, "reason", site.get("reason") if isinstance(site, dict) else "N/A")

        print(f"[{idx:02d}] 📌 {site_type}")
        print(f"     🔗 URL:    {url}")
        print(f"     💡 REASON: {reason}")
        print("-" * 80)
def main():
    scout = ResearchDiscoveryAgent()
    discovery_results = scout.discover_sites()
    print_discovery_results(discovery_results)


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(f"\n❌ Pipeline Execution Error: {e}")
        sys.exit(1)
