---
name: commit
description: Use when generating commit messages or committing changes. Produces a clear branch-level commit message, asks for backlog linkage, and requires approval before any git commit.
---

# Commit Message

## Rules

- Use this for every commit message Codex writes, unless explicitly told otherwise.
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
<Title: short statement of the resulting behavior; see Title Style. No Conventional Commits. One sentence without `.`.>

Summary
<1-3 short sentences, at most 60 words: "Before this change, …", "After this change, …" and, if needed, what rollout still depends on. The effect of merging, not the technical changes. No hard line wraps.>

Key changes
- <one line, at most 25 words: what changed + why it matters>
- <at most 6 bullets>

Backlog
<exact text the user provided>
```

Omit `Backlog` entirely if the user answered `No`.

## Length

Keep the message short enough to read in one glance. These are hard limits, not targets:

- Title: at most 72 characters.
- Summary: 1-3 sentences and at most 60 words in total. One idea per sentence; no chains of clauses joined by semicolons or `and ... so ... and`.
- Key changes: at most 6 bullets, each one line of at most 25 words. Group related edits into one bullet (e.g. all tests, all docs, all RBAC) instead of one bullet per file.
- Do not repeat in Key changes what the Summary already says, and leave out mechanical edits such as kustomization entries, regenerated golden files or comment rewording.
- Before presenting, count the Summary's words and the bullets, and cut until the message fits. Prefer dropping detail over compressing it into longer sentences.

## Title Style

The title states what is true once the commit lands, with the affected thing as its subject, in present tense:

- Do not open with a change verb such as `Made`, `Added`, `Updated`, `Fixed`, `Improved`, `Enhanced` or `Introduced`. Drop the verb and say what the system does instead.
- Name the concrete thing that changed (component, check, resource, flow) rather than a generic area.

Examples:

- `Helm chart sync checks ignore trailing blank lines`, not `Made Helm chart sync checks ignore trailing blank lines`
- `Default Pod spreading is scoped to the current ReplicaSet`, not `Scoped default Pod spreading to the current ReplicaSet during rollouts`
- `Scheduled vulnerability checks report failures`, not `Strengthened scheduled vulnerability checks and their failure reporting`

## Summary Style

The Summary explains what merging the commit does for the system and the people who use it; Key changes cover what changed in the code. Write it for a reader who wants to know what is different afterwards, and make it unmistakable which sentence describes the state before the commit and which the state after it:

- Start with "Before this change, …": the old behavior or problem, in past tense, e.g. "Before this change, a resource a Tenant stopped composing stayed Terminating." Keep every verb in that sentence in past tense, including in subordinate clauses. Leave it out when the commit adds a capability that simply did not exist and there is no problem to state.
- Continue with "After this change, …": the new behavior, in present tense, in user-facing terms, e.g. "After this change, owners manage access through group membership in Entra ID." Name the most important new guarantee or restriction here as an effect, e.g. "and admission rejects RoleBindings to anyone else". Leave lesser ones to Key changes.
- Do not use future tense or "now" in either sentence.
- When rollout depends on something, add one short last sentence about what merging alone does not do, e.g. "Clusters keep `function-tenant` v0.1.0 until 0.2.0 is rolled out."
- Leave file names, function names and implementation mechanics to Key changes unless the reader needs one to understand the effect.

Example:

> Before this change, Tenants gave their teams no access to `<name>-apps`. After this change, three Entra ID groups bound to `admin`, `edit` and `view` grant it, owners manage it through group membership, and admission rejects RoleBindings to anyone else. Clusters keep `function-tenant` v0.1.0 until 0.2.0 is rolled out.

## Quality Bar

- Each bullet stands alone; avoid vague `refactoring`, `cleanup`, or `misc changes`.
- Use inline code formatting for paths, functions, schemas, and commands.
- Write for someone reviewing the PR later without the diff open.
- Include security-relevant removals or restrictions in the Summary, especially when the change removes adoption, reuse, compatibility, or ownership-transfer behavior.
- In Key changes, describe authored changes rather than narrating runtime behavior. Prefer past-tense change verbs such as `Added`, `Removed`, `Consolidated`, `Introduced`, `Strengthened`, and `Updated`. The Summary is the exception: it describes the resulting behavior (see Summary Style).
- Before presenting the message, check it against the limits in Length, and verify that every Key changes bullet answers “what changed and why it matters?” rather than only “what does the code do?”, and that the Summary answers “what is different for the system and its users after merging?” rather than listing changes.
- Prefer precise lifecycle wording for shared infrastructure: distinguish resources that are created when absent, accepted when present, retained, or deleted.
- For broad changes spanning several controls, title the shared outcome (e.g. `Tenant namespaces accept access only through Entra groups`) rather than listing each control or falling back to `Enhanced ...`.
