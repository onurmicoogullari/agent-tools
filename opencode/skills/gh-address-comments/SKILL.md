---
name: gh-address-comments
description: Use when addressing GitHub PR review comments or issue comments on the current branch. Uses gh CLI to fetch comments, asks which to address, then applies selected fixes.
---

# GitHub PR Comment Handler

Use this skill to inspect and address review comments on the open GitHub PR for the current branch.

## Rules

- Use `gh` for GitHub operations.
- Verify `gh auth status` first. If unauthenticated, ask the user to run `gh auth login`.
- Do not push or resolve conversations unless the user explicitly asks.
- Ask which comments to address before editing.

## Workflow

1. Resolve this skill folder from the loaded SKILL.md path, then run the bundled script from the repo root:

   ```bash
   python3 "<path-to-this-skill>/scripts/fetch_comments.py"
   ```

2. Summarize all review threads and comments needing attention.
3. Number each item and describe the likely fix.
4. Ask the user which numbered items to address.
5. Apply fixes only for selected comments.
6. Run the smallest relevant verification.
7. Summarize what was addressed and what remains.

If `gh` reports auth/rate-limit issues, stop and ask the user to re-authenticate or retry later.
