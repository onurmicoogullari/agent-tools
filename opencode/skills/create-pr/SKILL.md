---
name: create-pr
description: Use when creating a GitHub pull request with gh. Builds a structured PR body from the branch commit message, pushes if needed, creates the PR, and returns the URL.
---

# Create Pull Request

## Rules

- Only create a PR when the user explicitly asks.
- Use `gh` for GitHub operations.
- Never mention AI/tooling, include `Co-Authored-By`, or add a `Test plan` section.
- The PR title should always be one sentence without `.`.
- Before creating the PR, inspect status, branch, remote tracking, recent commits, and diff from the base branch.

## Body

Use the branch commit message from the `commit` skill as the body, adjusted for Markdown:

- Convert `Summary`, `Key changes`, and `Backlog` headings to `## Summary`, `## Key changes`, and `## Backlog`.
- If an Azure DevOps item is linked, preserve `AB#<number>` exactly.
- Do not invent testing notes unless they are already part of the commit message.

## Execution

1. Determine base branch: `main` or `master` unless specified.
2. Fetch the base branch from `origin`, then rebase the current branch onto `origin/<base>` before creating the PR.
3. Push the branch if it is not already pushed.
4. Run `gh pr create` with the formatted title/body.
5. Return only the PR URL plus any important follow-up.
