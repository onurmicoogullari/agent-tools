---
name: commit
description: Use when generating commit messages or committing changes. Produces a clear branch-level commit message, asks for backlog linkage, and requires approval before any git commit.
---

# Commit Message

## Rules

- Use this for every commit message OpenCode writes, unless explicitly told otherwise.
- Always inspect the branch before writing the message: `git status`, the diff from the base branch, and recent commits.
- Reuse any backlog answer already given for this work. If none was given, ask first: `Should this commit be linked to a backlog item? If yes, provide the exact text such as Fixes AB#123 or Relates to AB#123. If no, respond No.`
- Print the full commit message and wait for explicit approval before committing.
- Only run `git commit` if the user explicitly asked to commit. Otherwise stop after producing the message.
- Never include `Co-Authored-By` lines or mention AI/tooling.

## Scope

For a branch-summary request, describe the branch as one logical unit. Resolve the base from the user’s instruction, PR metadata, or the remote default branch; use `main` or `master` only when unambiguous. Inspect the merge-base diff, recent commits, staged and unstaged changes, and relevant untracked files. State any exclusions.

For an actual commit, write the message for the exact changes selected for that commit. Verify the staged diff before committing; do not describe earlier commits or files left out of the index as part of the new commit. Preserve unrelated changes.

## Format

```text
<Title: short, descriptive, past tense. No Conventional Commits. The commit title should always be one sentence without `.`.>

Summary
<1-3 sentences: what was done and why, not how. No hard line wraps.>

Key changes
- <meaningful change, what + why it matters>
- <...>

Backlog
<exact text the user provided>
```

Omit `Backlog` entirely if the user answered `No`.

## Quality Bar

- Each bullet stands alone; avoid vague `refactoring`, `cleanup`, or `misc changes`.
- Use inline code formatting for paths, functions, schemas, and commands.
- Write for someone reviewing the PR later without the diff open.
- Include security-relevant removals or restrictions in the Summary, especially when the change removes adoption, reuse, compatibility, or ownership-transfer behavior.
- Describe authored changes rather than narrating runtime behavior. Prefer past-tense change verbs such as `Added`, `Removed`, `Consolidated`, `Introduced`, `Strengthened`, and `Updated`.
- Before presenting the message, verify that every Key changes bullet answers “what changed and why it matters?” rather than only “what does the code do?”
- Prefer precise lifecycle wording for shared infrastructure: distinguish resources that are created when absent, accepted when present, retained, or deleted.
- For broad improvements spanning several controls, prefer a neutral title such as `Enhanced ...`; use `Enforced ...` only when the primary change adds enforcement for an existing rule.
