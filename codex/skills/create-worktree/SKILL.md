---
name: create-worktree
description: "Use when creating or resuming an isolated git worktree for a feature, fix, refactor, or task before making code changes."
---

# Create Worktree

## Rules

- Use a worktree before writing code for non-trivial features, fixes, or refactors unless the user explicitly says not to.
- Check existing worktrees first and reuse one when it clearly matches the task.
- Keep all planning, coding, searching, and testing scoped to the selected worktree after creation.

## Workflow

1. Check existing worktrees: `git worktree list`.
2. If relevant worktrees exist, list them with branch names and ask whether to resume or create a new one.
3. Gather missing basics only: work type (`fix`, `feat`, `refact`) and a short task description.
4. Derive a kebab-case branch: `<type>/<description>`, for example `fix/auth-timeout`.
5. Create the worktree under `.worktrees/<branch-name>` from the default base branch.
6. Ensure `.worktrees/` is ignored if the repo does not already ignore it.
7. Continue from inside the worktree path.

## Fallback Command

```bash
mkdir -p .worktrees
```

Use the repo's actual base branch instead of `origin/main` when different.
