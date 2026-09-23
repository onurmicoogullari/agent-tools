# AGENTS.md

## Git Branches and Worktrees

Do not create git worktrees yourself. Codex manages them in both the app and
the CLI.

- In a Codex worktree, which starts on a detached HEAD, create the branch in
  place before making changes: `git switch -c <prefix>/<short-description>`.
- In the main checkout, ask before switching branches. For parallel work,
  suggest a worktree session instead: Worktree mode in the app, or `/worktree`
  in the CLI.

Never create branches with the `codex/` prefix.

Name branches `<prefix>/<short-description>` in kebab case, for example
`fix/auth-timeout`. Choose the prefix based on the content of the change:

- `feat/` for new features or meaningful capability additions.
- `fix/` for bug fixes, broken behavior, or regressions.
- `docs/` for documentation-only changes, including corrections, new pages,
  guides, and documentation restructuring.
- `refact/` for behavior-preserving restructuring that improves clarity, reuse,
  or maintainability.
- `chore/` for maintenance, tooling, dependency updates, formatting, or
  repository hygiene.

If the repository's `AGENTS.md` defines its own branch naming, follow that
instead.

## Response Style

Apply these rules to chat responses, plans, reviews, explanations, and
summaries. If the task requires a specific format, follow that format instead.

Above all, make the response easy to skim and understand. Ignore any rule below
that gets in the way of clarity.

- Lead with the answer or recommendation. Skip warm-up paragraphs.
- Use short sections with clear headings. Use emoji in headings only when it
  helps navigation.
- Prefer tight bullets and short paragraphs. A one-line bullet with a bold
  lead-in often works best.
- Use tables or diagrams when they communicate faster than prose, but keep them
  readable on a narrow screen.
- Make the call plainly. Mention the main alternative briefly when it matters.
- Use human language. Name the actual thing instead of using internal labels,
  shorthand, or unnecessary jargon.
- Remove repetition, filler, and anything that does not help the reader act or
  understand.
- Prefer shorter responses unless detail is necessary for correctness.

## PR Review Comments

When drafting a review comment to post on a pull request:

- Write casually, like a teammate typing it by hand. No headings, bold
  labels, priority or severity tags (P0–P3), or verdict boilerplate.
- Open directly with the suggestion, e.g. "Instead of X, we can Y." Skip
  praise and warm-up.
- Briefly explain why the suggested approach is better.
- Recommend one path. Don't discuss ways to keep or patch the rejected
  approach.
- Link existing examples of the pattern in the repo, using permalinks
  pinned to a commit.
- Include a concrete snippet of the change when it helps.
- Leave out how I verified it and follow-up reminders unless asked.
- Show the draft first and post only after I approve. Default to a
  "Request changes" review when the issue should block merge.
