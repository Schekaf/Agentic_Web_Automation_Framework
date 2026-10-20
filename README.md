# 🎭 (Behavior-Driven) Agentic Web Automation Framework

A scalable, maintainable End-to-End (E2E) UI testing framework built with **Python**, **Selenium WebDriver**, and **Behave (BDD)**, implementing the **Page Object Model (POM)** architecture—empowered by an advanced **Multi-Agent AI Pipeline** for automated test generation, feasibility auditing, coverage planning, and safety-critical sector benchmarking.

---

## 🌟 Key Features

- **Behavior-Driven Development (BDD):** Human-readable Gherkin scenarios enabling clear communication between technical and non-technical stakeholders.
- **Page Object Model (POM):** Clean separation of test logic, step definitions, and UI locators for high maintainability and low test flakiness.
- **Multi-Agent AI Ecosystem:** Automated pipelines featuring **Sector Benchmarking** for standards compliance insights, **Lessons Learned & Self-Correction** memories enabling agents to learn from past mistakes and refine execution, and **Coach Agents** that optimize workflows, guide feature design, and eliminate redundant tasks.
- **Cross-Browser & Headless Support:** Easily toggle execution across Chrome, Firefox, or Edge in both headed and headless modes.
- **Hooks & Dynamic Environment Setup:** Automated browser lifecycle management, teardown, and screenshot capture on failure via `environment.py`.
- **Rich Test Reporting:** Out-of-the-box integration for interactive Allure and HTML test reports.

---

## 🛠️ Tech Stack & Dependencies

- **Language:** Python 3.x
- **BDD Framework:** [Behave](https://behave.readthedocs.io/)
- **Browser Automation:** [Selenium WebDriver](https://www.selenium.dev/)
- **AI & Orchestration:** LangChain, Pydantic, ChatOllama / Local LLMs
- **Design Pattern:** Page Object Model (POM)
- **Designated Runner / Utils:** `ddgs`, `BeautifulSoup4`, `behave`, `drain3`, `ruff`

---

## ⚡ Dynamic Step Parameters

The framework automatically intercepts step arguments at runtime and transforms special keyword placeholders before executing the step logic.

### 🔑 Supported Keywords

| Keyword | Description | Example Input | Example Output |
| :--- | :--- | :--- | :--- |
| `<TODAY>` | Replaces with current date (`DD/MM/YYYY`) | `Date: <TODAY>` | `Date: 07/10/2026` |
| `<PASTE>` | Replaces with OS clipboard contents | `<PASTE>` | `Clipboard text` |
| `<EMPTY>` | Replaces parameter with an empty string `""` | `<EMPTY>` | `""` |
| `<NOTHING>` | Replaces parameter with an empty string `""` | `<NOTHING>` | `""` |
| `<SKIP>` | Skips step execution entirely | `<SKIP>` | *(Step skipped)* |
| `<RANDOM>` | Generates a random 6-letter string and caches it | `User_<RANDOM>` | `User_aBqXzL` |
| `<RANDOM:N>` | Generates a random $N$-letter string (e.g., length 8) | `Code_<RANDOM:8>` | `Code_fRmLpQzA` |
| `<GETRANDOM>` | Retrieves the last generated `<RANDOM>` string | `Confirm <GETRANDOM>` | `Confirm aBqXzL` |
| `<RANDOM:key>` | Generates a random 4-digit number and caches it under `key` | `<RANDOM:user_id>` | `3921` |
| `<GET:key>` | Retrieves the cached value stored under `key` | `<GET:user_id>` | `3921` |

#### Gherkin Examples

```gherkin
Scenario: Dynamic parameter usage in feature files
  When I enter "<TODAY>" into "Registration Date" field
  And I enter "<PASTE>" into "Notes" field
  And I enter "<EMPTY>" into "Middle Name" field
  And I enter "<SKIP>" into "Optional Field" field
  And I enter "User_<RANDOM:8>" into "Username" field
  And I enter "<RANDOM:user_id>" into "User ID" field
  Then I verify field "Confirmation" matches "<GETRANDOM>"
  And I verify user "<GET:user_id>" was successfully created
```

## 📁 Project Architecture

```text
Agentic_Web_Automation_Framework/
├── ai_agents/                                              # Multi-agent AI orchestration directory
│   ├── core/                                               # Shared agent data layer, configs, & utils
│   │   ├── __init__.py
│   │   ├── base_agent.py                                   # Core agent abstraction
│   │   ├── config.py                                       # Global model and path configurations
│   │   ├── discovered_sites.json                           # Verified technical & testing URLs
│   │   ├── lessons_learned.json                            # Historical reflection logs for agents
│   │   ├── lessons_learned_manager.py                      # Agent memory and feedback loop manager
│   │   ├── model_selector.py                               # Interactive CLI model switcher & registry
│   │   ├── orchecstrator.py                                # Master CLI orchestrator for multi-agent workflows
│   │   ├── qa_sector_insights.json                         # Harvested safety & testing benchmark data
│   │   ├── schemas.py                                      # Shared Pydantic structured output models
│   │   ├── step_library.py                                 # Reusable Behave step registry
│   │   ├── step_scanner.py                                 # Automated codebase step pattern analyzer
│   │   ├── tradehub_domain.py                              # TradeHub domain entities & prompt contexts
│   │   └── utils.py                                        # Sanitization, regex matching & chunking helpers
│   │
│   ├── qa_automation_feasibility_agent/                    # Feasibility auditing & pattern parameter agents
│   │   ├── __init__.py
│   │   ├── pattern_audit_agent.py                          # Audits test steps for parameterized patterns
│   │   ├── pattern_parameter_resolution_agent.py           # Resolves dynamic tags/parameters
│   │   └── test_automatable_feasibility_agent.py           # Evaluates UI checklist automation feasibility
│   │
│   ├── qa_coach_agent/                                     # Multi-turn interactive coaching modules
│   │   ├── __init__.py
│   │   ├── test_autamation_feasibility_coach.py            # Coaching module for automation readiness
│   │   ├── test_generation_coach.py                        # Interactive guide for Gherkin test design
│   │   ├── test_step_audit_coach.py                        # Coaching on step definitions & clean patterns
│   │   └── test_step_implementation_generation_coach.py    # Step code creation guide
│   │
│   ├── qa_coverage_planner_agent/                          # Intelligent test coverage planning agent
│   │   ├── __init__.py
│   │   └── test_coverage_planner_agent.py                  # Plans and maps feature test coverage matrix
│   │
│   ├── qa_sector_benchmark_agent/                          # Research discovery & sector benchmarking agents
│   │   ├── __init__.py
│   │   ├── research_discovery_agent.py                     # Web scout for testing standards & blogs
│   │   └── sector_benchmarking_agent.py                    # Harvester & extractor for ISO/DO compliance insights
│   │
│   ├── qa_test_fixer_agent/                                # Automated failure analysis & test repair agent
│   │   ├── __init__.py
│   │   └── test_fixer_agent.py                             # Analyzes broken tests/locators and applies fixes
│   │
│   ├── qa_test_generator_agent/                            # Automated Gherkin feature file generation agent
│   │   ├── __init__.py
│   │   └── test_generator.py                               # Converts natural language checklists into Gherkin features
│   │
│   └── qa_test_step_generator_agent/                       # Intelligent Behave step definition generation agents
│       ├── __init__.py
│       ├── test_step_generator.py                          # Generates functional Behave step implementations
│       ├── test_step_reviewer.py                           # Reviews and validates generated step code quality
│       └── test_step_skeleton_generator.py                 # Scaffolds step definition skeletons from feature files
│
├── elements/                                               # Locators (external ini/json configs)
│   ├── home_page.ini
│   └── tradehub_home.ini
│
├── features/                                               # Behave BDD Layer
│   ├── steps/                                              # Step definitions (links Gherkin to PageObjects)
│   │   ├── action_steps.py
│   │   ├── browser_steps.py
│   │   ├── validation_steps.py
│   │   └── generated_by_ai_steps.py                        # Auto-generated step definitions from Agent 2
│   ├── environment.py                                      # Behave hooks (driver init, failure screenshots)
│   └── *.feature                                           # Auto-generated feature files from Agent 1
│
├── page_objects/                                           # Page Object Model Layer
│   ├── __init__.py
│   ├── base_page.py                                        # Core driver wrappers (click, fill, wait)
│   └── home_page.py                                        # Page-specific actions & locators
│
├── reports/                                                # Test execution outputs & failure artifacts
│
├── utilities/                                              # Framework core utilities
│   ├── common.py                                           # General helper methods
│   ├── element_helper.py                                   # Advanced element handling
│   ├── step_helper.py                                      # Step logging / dynamic params
│   └── web_driver.py                                       # Driver setup (via webdriver-manager)
│
├── .env                                                    # Local environment variables
├── .gitignore                                              # Excludes venv, reports, .env, drivers
├── behave.ini                                              # Behave execution settings
├── generate_features.py                                    # Entry point CLI runner for Agent 1
├── generate_steps.py                                       # Entry point CLI runner for Agent 2 
├── research_pipeline.py                                    # CLI orchestrator for Discovery & Sector Benchmarking
├── run_agent_pipeline.py                                   # Master CLI orchestrator for multi-agent workflows
├── README.md                                               # Project documentation
└── requirements.txt                                        # Dependencies
```

### 📐 AI Agent Pipeline Architecture Schema

https://www.tldraw.com/f/Tdx8qhVxI5CXyUrISzc06?d=v8323.-1901.5492.2606.page


## 🚀 Test Execution Guide

Tests are executed using **Behave** (BDD framework). You can customize runs using tags, browser selection, and CLI flags.

### 1. Basic Execution Commands

Run all feature files in default browser (Chrome):
```bash
behave
```
Run a specific feature file:
```bash
behave features/practice_tests.feature
```
### 2. Running by Tags
Run tests tagged with @Register:
```bash
behave features/practice_tests.feature -t Register
```
### 3. Cross-Browser Testing
You can specify the target browser dynamically via the `-D browser` flag. Supported browsers: `chrome`, `firefox`, `edge`.
```bash
behave features/practice_tests.feature -t Register -k -D browser=chrome
```

---

## 📜 Licensing & Commercial Use

This project is dual-licensed:

1. **Open Source Use (GNU GPLv3):** Free for open-source projects, individuals, and education under the terms of the GNU General Public License v3.0.
2. **Commercial / Proprietary Use:** If you wish to use this framework in closed-source commercial applications without being bound by GPLv3 copyleft terms, a commercial license is required.

For full license terms, see the [LICENSE](LICENSE) file.

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

For commercial licensing inquiries, contact: `furkan.kiziltepe@gmail.com`



