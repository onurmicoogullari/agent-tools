---
name: notion-research-documentation
description: Research across Notion and synthesize into structured documentation; use when gathering info from multiple Notion sources to produce briefs, comparisons, or reports with citations.
metadata:
  short-description: Research Notion content and produce briefs/reports
---

# Research & Documentation

Pull relevant Notion pages, synthesize findings, and publish clear briefs or reports (with citations and links to sources).

## Tool names

Names such as `Notion:notion-search` below and in the references identify operations, not guaranteed callable tool names. Discover the Notion tools exposed in this session and follow their actual schemas.

## Quick start
1) Find sources with `Notion:notion-search` using targeted queries; confirm scope with the user.
2) Fetch pages via `Notion:notion-fetch`; note key sections and capture citations (`reference/citations.md`).
3) Choose output format (brief, summary, comparison, comprehensive report) using `reference/format-selection-guide.md`.
4) Draft in Notion with `Notion:notion-create-pages` using the matching template (quick, summary, comparison, comprehensive).
5) Link sources and add a references/citations section; update as new info arrives with `Notion:notion-update-page`.

## Workflow
### 0) Check the Notion connection
Use an existing connected Notion integration first. If the tools are missing or authentication has expired, use the host’s connection flow. For a CLI-managed MCP connection:

1. Check the existing connection with `opencode mcp list`.
2. If no suitable Notion connection exists, merge `"notion": {"type": "remote", "url": "https://mcp.notion.com/mcp", "enabled": true}` into the active configuration’s `mcp` object. Preserve other settings.
3. Authenticate with `opencode mcp auth notion` and verify that Notion tools are available.

Let the user complete interactive authentication. Resume when tools are available; restart the session only if the host requires it. Treat other API errors according to the returned error instead of reconnecting automatically.

### 1) Gather sources
- Search first (`Notion:notion-search`); refine queries, and ask the user to confirm if multiple results appear.
- Fetch relevant pages (`Notion:notion-fetch`), skim for facts, metrics, claims, constraints, and dates.
- Track each source URL/ID for later citation; prefer direct quotes for critical facts.

### 2) Select the format
- Quick readout → quick brief.
- Single-topic dive → research summary.
- Option tradeoffs → comparison.
- Deep dive / exec-ready → comprehensive report.
- See `reference/format-selection-guide.md` for when to pick each.

### 3) Synthesize
- Outline before writing; group findings by themes/questions.
- Note evidence with source IDs; flag gaps or contradictions.
- Keep user goal in view (decision, summary, plan, recommendation).

### 4) Create the doc
- Pick the matching template in `reference/` (brief, summary, comparison, comprehensive) and adapt it.
- Create the page with `Notion:notion-create-pages`; include title, summary, key findings, supporting evidence, and recommendations/next steps when relevant.
- Add citations inline and a references section; link back to source pages.

### 5) Finalize & handoff
- Add highlights, risks, and open questions.
- If the user needs follow-ups, create tasks or a checklist in the page; link any task database entries if applicable.
- Share a short changelog or status using `Notion:notion-update-page` when updating.

## References and examples
- `reference/` — search tactics, format selection, templates, and citation rules (e.g., `advanced-search.md`, `format-selection-guide.md`, `research-summary-template.md`, `comparison-template.md`, `citations.md`).
- `examples/` — end-to-end walkthroughs (e.g., `competitor-analysis.md`, `technical-investigation.md`, `market-research.md`, `trip-planning.md`).
