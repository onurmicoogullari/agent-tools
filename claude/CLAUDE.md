# CLAUDE.md

## Git Worktrees and Branches

Before making any file change in a git repository, use the `create-worktree`
skill to create or resume a worktree on its own branch. Skip the worktree for
read-only work or when the user says not to. Use the skill's branch naming
rules whenever you create a branch, with or without a worktree.

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

## Skills and delegated work

Use skills in the main session for reusable workflows and subject expertise. Keep interviews, approval gates, and workflows relying on conversation history in the main session. Use native agent profiles for bounded independent assignments. Only delegate writing work when the user explicitly requests subagents; assign non-overlapping ownership.

Architect, debugger, researcher, and reviewer profiles perform read-only work. Shell commands and remote tools must respect that boundary as well. Do not assume that loading a skill grants permission for an external action.
