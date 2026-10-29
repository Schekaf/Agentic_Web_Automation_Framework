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

import glob
import json
import os
import re
import functools
import subprocess
import time
from pathlib import Path
from typing import List, Dict, Any

from drain3 import TemplateMiner
from drain3.template_miner_config import TemplateMinerConfig
from selenium.webdriver.common.by import By

from ai_agents.core.schemas import LocatorFileSchema, LocatorSection
from ai_agents.core.step_scanner import get_undefined_steps_via_behave, get_step_info

PERF_LIST = {
}


def timer(func):
    """Decorator to measure execution time of any function."""

    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        t_start = time.perf_counter()
        result = func(*args, **kwargs)
        t_end = time.perf_counter()
        print(f"\033[33m⚡ [PERF] `{func.__name__}` took {t_end - t_start:.3f}s to run.\033[0m")
        PERF_LIST[func.__name__] = t_end - t_start
        return result

    return wrapper


def rest_check(func):
    """
    Decorator to monitor GPU temperature before running a function.
    If GPU temperature exceeds `temp_limit`, pauses execution for `cooldown_sec`.
    """

    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        try:
            output = subprocess.check_output(
                ["nvidia-smi", "--query-gpu=temperature.gpu", "--format=csv,noheader,nounits"],
                encoding="utf-8"
            )
            temp = int(output.strip().split("\n")[0])

            if temp >= 75:
                print(f"\n🔥 [Thermal Guard] GPU temp high: 75°C! Pausing agent for 60 seconds...")
                time.sleep(60)
                print("❄️ Resuming execution.")
        except Exception as e:
            pass  # Ignore if

        return func(*args, **kwargs)

    return wrapper


def pre_mask_step(step_text: str) -> str:
    """
    Masks string literals in quotes and numbers into explicit placeholders BEFORE
    Drain processes them, protecting verbs like 'click', 'enter', and 'see'.
    """
    # Preserve quotes, mask inner content to "<PARAM>"
    masked = re.sub(r'(["\'])(.*?)\1', r'"<PARAM>"', step_text)
    # Mask standalone numbers
    masked = re.sub(r'\b\d+(\.\d+)?\b', '<PARAM>', masked)
    return masked


def collapse_drain_patterns(drain_lines: list[str]) -> list[str]:
    """
    Transforms Drain3 output lines by replacing all double-quoted strings
    and Drain3 tokens (<PARAM>, <NUM>, <*>) with unified {param} placeholders.
    """
    collapsed_patterns = set()

    for line in drain_lines:
        line = line.strip()
        if not line:
            continue

        # 1. Replace ANY double-quoted string "..." with {param}
        # Handles long phrases like "Develop a new web application with advanced features"
        line_clean = re.sub(r'"[^"]*"', '{param}', line)

        # 2. Replace single-quoted strings '...' with {param}
        line_clean = re.sub(r"'[^']*'", '{param}', line_clean)

        # 3. Replace Drain3 wildcard tokens (<PARAM>, <NUM>, <*>)
        line_clean = re.sub(r'(\<(PARAM|NUM|\*)\>\s*)+', '{param} ', line_clean)
        line_clean = line_clean.replace('<PARAM>', '{param}').replace('<NUM>', '{param}').replace('<*>', '{param}')

        # 4. Collapse multiple consecutive {param} placeholders into a single {param}
        # (e.g., if Drain3 produced "<*> <*>", collapse it to one "{param}")
        line_clean = re.sub(r'(\{param\}\s*)+', '{param} ', line_clean)

        # 5. Clean up extra spaces
        line_clean = re.sub(r'\s+', ' ', line_clean).strip()

        # 6. Re-wrap parameters in clean quotes for standard Gherkin syntax
        line_clean = line_clean.replace('{param}', '"{param}"')

        collapsed_patterns.add(line_clean)

    return sorted(list(collapsed_patterns))


def aggregate_by_verb_prefix(patterns: list[str]) -> list[str]:
    """
  If a longer, more parameterized pattern exists for a verb prefix,
  drops the shorter ambiguous versions.
  """
    # Sort by length descending so longer, more specific patterns take priority
    sorted_patterns = sorted(patterns, key=len, reverse=True)
    final_patterns = []

    for p in sorted_patterns:
        # Check if this pattern is a subset/prefix of an already accepted pattern
        is_subset = False
        for accepted in final_patterns:
            # If 'I select "{param}"' is inside 'I select "{param}" as "{param}"', skip the short one!
            prefix_stem = p.split('"{param}"')[0].strip()
            if prefix_stem and prefix_stem in accepted and len(p) < len(accepted):
                is_subset = True
                break

        if not is_subset:
            final_patterns.append(p)

    return sorted(final_patterns)


def split_instructions_into_sections(raw_text: str) -> list[str]:
    """Splits raw instructions into section chunks (matching lines starting with numbers like '1. ', '2. ')."""
    pattern = r'(?=\b\d+\.\s+[A-Z])'
    sections = re.split(pattern, raw_text)
    return [sec.strip() for sec in sections if sec.strip()]


def clean_gherkin_output(raw_text: str) -> str:
    """Removes conversational AI intros, markdown artifacts, and code fences."""
    # Strip markdown code fences
    cleaned = re.sub(r'```[a-zA-Z]*', '', raw_text).replace('```', '').strip()

    clean_lines = []
    for line in cleaned.splitlines():
        trimmed = line.strip()
        # Filter out conversational headers and markdown bold artifacts
        if (trimmed.startswith("**") or
                "Here are the" in trimmed or
                "Behave Gherkin" in trimmed or
                trimmed.startswith("Here is")):
            continue
        clean_lines.append(line)

    return "\n".join(clean_lines).strip()


def discover_all_feature_files(features_dir: str, model_slug: str = None) -> list[str]:
    """Recursively finds .feature files under features/. Filtered by model_slug if provided."""
    all_feature_files = glob.glob(os.path.join(features_dir, "**", "*.feature"), recursive=True)

    if model_slug:
        # Match files ending with `_{model_slug}.feature`
        target_suffix = f"_{model_slug}.feature"
        matched_files = [f for f in all_feature_files if
                         os.path.basename(f).endswith(target_suffix) and "archive" not in f.lower()]
        return sorted(matched_files)

    return sorted(all_feature_files)


def sanitize_model_tag_for_filename(model_tag: str) -> str:
    """Converts a model tag like 'qwen2.5-coder:7b' to a clean file-friendly string 'qwen2_5_coder_7b'."""
    # Replace colons, hyphens, and dots with underscores
    clean_tag = re.sub(r"[:\.\-]", "_", model_tag)
    # Remove any other non-alphanumeric/underscore characters
    return re.sub(r"[^a-zA-Z0-9_]", "", clean_tag)


def clear_ai_generated_steps_file(output_file_path: str):
    """Safely clears/truncates the generated step file without deleting it."""
    os.makedirs(os.path.dirname(output_file_path), exist_ok=True)
    with open(output_file_path, "w", encoding="utf-8") as f:
        f.truncate(0)


def collapse_drain_wildcards(drain_patterns: list[str]) -> list[str]:
    """
    Collapses multi-token Drain wildcards like '<*> <*> <*>' into a single '<*>'
    and returns a deduplicated list.
    """
    # Matches one or more '<*>' tokens separated by spaces/whitespace
    wildcard_pattern = re.compile(r'(?:<\*>\s*)+')

    unique_patterns = set()
    for pattern in drain_patterns:
        # Replace consecutive wildcards with a single '<*>'
        collapsed = wildcard_pattern.sub('<*> ', pattern).strip()
        unique_patterns.add(collapsed)

    return list(unique_patterns)


def mine_patterns_with_drain(raw_steps: list[str]) -> list[str]:
    """Runs raw Drain3 log template mining on raw undefined steps."""
    config = TemplateMinerConfig()
    config.profiling_enabled = False
    config.drain_depth = 5
    config.drain_sim_th = 0.1  # Slightly lower threshold lets Drain group similar steps
    config.masking_instructions = [
    ]

    miner = TemplateMiner(config=config)

    for step in raw_steps:
        miner.add_log_message(step)

    # Return pure cluster templates from Drain3
    drained_steps = [cluster.get_template() for cluster in miner.drain.clusters]
    return collapse_drain_wildcards(drained_steps)


def collect_raw_steps(feature_files: list[str], tag: str | None = None) -> tuple[list[dict], list[str]]:
    """Runs behave dry-run across feature files and returns mapped steps and a flattened list."""
    feature_steps_map = []
    all_raw_steps = []

    for feature_file in feature_files:
        tags_param = [tag] if tag else None
        steps = get_step_info([feature_file], tags=tags_param)
        ## steps = get_undefined_steps_via_behave([feature_file], tags=tags_param)
        if steps:
            feature_steps_map.append({"file": feature_file, "steps": steps})
            all_raw_steps.extend(steps)

    return feature_steps_map, all_raw_steps


def audit_steps_via_behave(feature_files: list[str]) -> list[dict]:
    """
    Runs behave --dry-run and returns a list of issues found
    (e.g., undefined steps, AmbiguousStep conflicts, or syntax errors).
    Returns an empty list [] if everything is clean.
    """
    cmd = ["behave", "--dry-run", "--format", "json", "--no-summary", "--no-snippets"]
    cmd.extend(feature_files)

    result = subprocess.run(cmd, capture_output=True, text=True)
    issues = []

    # If returncode is 0, all steps are defined and valid
    if result.returncode == 0:
        return issues

    # Combined output for error inspection
    error_output = (result.stderr + "\n" + result.stdout).strip()

    if "AmbiguousStep" in error_output:
        # Extract the conflicting step patterns using regex
        # Behave format typically says: @step('...') has already been defined in ... existing step @step('...')
        issues.append({
            "issue_type": "ambiguous_step_conflict",
            "detail": error_output,
            "action_required": "Remove redundant/hardcoded step definition in favor of the parameterized wildcard."
        })
    else:
        # Capture any other errors, including undefined steps or syntax issues
        issues.append({
            "issue_type": "undefined_or_other_error",
            "detail": error_output,
            "action_required": "Investigate the error output for missing step definitions or Gherkin syntax issues."
        })
    return issues


def harvest_page_elements(driver, url: str) -> List[Dict[str, str]]:
    """
    Navigates to the given URL and extracts all visible, interactable elements
    (inputs, buttons, links, selects, labels) to serve as candidates for locator generation.
    """
    if url is not None:
        driver.get(url)
    else:
        print("⚠️ No URL provided for harvesting. Skipping page navigation.")
        return []
    candidates = []

    # Target common interactable element tags
    selector = "input, button, a, select, textarea, label"
    elements = driver.find_elements(By.CSS_SELECTOR, selector)

    for el in elements:
        try:
            # Skip hidden elements to keep data clean and concise
            if not el.is_displayed():
                continue

            tag = el.tag_name.lower()
            el_id = el.get_attribute("id") or None
            name = el.get_attribute("name") or None
            placeholder = el.get_attribute("placeholder") or None
            text_content = el.text.strip() or None
            aria_label = el.get_attribute("aria-label") or None

            # Construct reliable baseline candidate locators
            xpath = f"//{tag}"
            if el_id:
                xpath = f"//{tag}[@id='{el_id}']"
            elif placeholder:
                xpath = f"//{tag}[@placeholder='{placeholder}']"
            elif text_content:
                # Truncate long text content to prevent bloated payloads
                clean_text = text_content[:50]
                xpath = f"//{tag}[normalize-space()='{clean_text}']"
            elif name:
                xpath = f"//{tag}[@name='{name}']"

            css = f"#{el_id}" if el_id else tag

            candidates.append({
                "tag_name": tag,
                "element_id": el_id,
                "name": name,
                "placeholder": placeholder,
                "text_content": text_content,
                "aria_label": aria_label,
                "xpath_candidate": xpath,
                "css_candidate": css
            })
        except Exception:
            # Stale element or detached DOM reference protection
            continue

    return candidates


def parse_feature_files(features_dir: str = "features") -> List[Dict[str, Any]]:
    """
    Scans the features directory for all .feature files and extracts
    scenarios, their titles, steps, and associated page URLs.
    """
    all_scenarios = []

    if not os.path.exists(features_dir):
        print(f"Directory {features_dir} does not exist.")
        return all_scenarios

    for filename in os.listdir(features_dir):
        if filename.endswith(".feature"):
            file_path = os.path.join(features_dir, filename)
            with open(file_path, "r", encoding="utf-8") as f:
                content = f.read()

            # Parse scenarios using regex block separation
            scenario_blocks = content.split("Scenario:")

            for block in scenario_blocks[1:]:  # Skip feature-level header
                lines = [line.strip() for line in block.splitlines() if line.strip()]
                title = lines[0]

                steps = []
                page_url = None

                for line in lines[1:]:
                    # Skip tags if any
                    if line.startswith("@"):
                        continue

                    steps.append(line)

                    # Extract URL if it's a navigation step
                    url_match = re.search(r'Given I open "(https?://[^"]+)"', line)
                    if url_match:
                        page_url = url_match.group(1)

                all_scenarios.append({
                    "feature_file": filename,
                    "title": title,
                    "page_url": page_url,
                    "steps": steps,
                    "raw_text": f"Scenario: {title}\n" + "\n".join([f"  {s}" for s in steps])
                })

    return all_scenarios


def save_all_locators_to_ini(sections: List[LocatorSection], output_dir: str = "elements", file_name: str = "generated_by_ai_locators.ini"):
    os.makedirs(output_dir, exist_ok=True)
    file_path = Path(output_dir) / file_name

    # Group locators by section_name to avoid duplicate section headers
    grouped_sections = {}
    for section in sections:
        sec_name = section.section_name
        if sec_name not in grouped_sections:
            grouped_sections[sec_name] = {}
        # Merge locators into section dict
        grouped_sections[sec_name].update(section.locators)

    seen_keys = set()

    with open(file_path, "w", encoding="utf-8") as f:
        f.write("[locator]\n")
        for sec_name, locators in grouped_sections.items():
            f.write(f"## {sec_name}\n")
            for key, val in locators.items():
                if key not in seen_keys:
                    seen_keys.add(key)
                    f.write(f"{key} = {val}\n")
            f.write("\n")

    print(f"📁 Locators saved cleanly to: {file_path}")
