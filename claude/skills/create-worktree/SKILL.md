---
name: create-worktree
description: Use before making any file change in a git repository, or when creating a branch. Creates or resumes a sibling git worktree on its own branch, switches the session into it, and defines the branch naming rules.
---

# Create Worktree

## Rules

- Use a worktree for every change in a git repository, however small, unless
  the user explicitly says not to.
- Skip the worktree for read-only work, such as questions, reviews, and
  searches.
- Follow the branch naming rules below whenever you create a branch, even
  without a worktree.
- Keep all planning, coding, searching, and testing in the worktree after
  entering it.

## Branch Naming

Name branches `<prefix>/<short-description>` in kebab case, for example
`fix/auth-timeout`. Choose the prefix from the content of the change:

- `feat/` for new features or meaningful capability additions.
- `fix/` for bug fixes, broken behavior, or regressions.
- `docs/` for documentation-only changes, including corrections, new pages,
  guides, and documentation restructuring.
- `refact/` for behavior-preserving restructuring that improves clarity, reuse,
  or maintainability.
- `chore/` for maintenance, tooling, dependency updates, formatting, or
  repository hygiene.

If the repository's `AGENTS.md` or `CLAUDE.md` defines its own branch naming,
follow that instead.

## Workflow

1. Check that the working directory is inside a git repository:
   `git rev-parse --is-inside-work-tree`. If it is not, skip this skill.
2. Check whether the session is already in a linked worktree. If
   `git rev-parse --git-dir` differs from `git rev-parse --git-common-dir`, it
   is. Keep working there if its branch matches the task. Otherwise, continue
   with step 3 and switch to the right worktree.
3. Run `git worktree list`. If a worktree clearly matches the task, ask whether
   to resume it or create a new one.
4. Derive the branch name from the branch naming rules. Ask only when the
   prefix or description is unclear.
5. Create the worktree next to the main checkout. Name its directory
   `<repo>.<branch>`, with `/` in the branch replaced by `-`. For example,
   branch `fix/auth-timeout` in repository `app-platform` gets the directory
   `../app-platform.fix-auth-timeout`.
6. Switch the session into the worktree with the `EnterWorktree` tool, passing
   `path`. Do not pass `name`, because that creates a separate worktree under
   `.claude/worktrees/`.

## Commands

Run these from any checkout of the repository. They resolve the main checkout,
so they also work from inside another worktree.

```bash
main="$(dirname "$(git rev-parse --path-format=absolute --git-common-dir)")"
repo="$(basename "$main")"
branch="fix/auth-timeout"
wt_path="$(dirname "$main")/$repo.${branch//\//-}"

git -C "$main" fetch origin
base="$(git -C "$main" symbolic-ref --short refs/remotes/origin/HEAD)"
git -C "$main" worktree add -b "$branch" "$wt_path" "$base"
```

If `origin/HEAD` is not set, run `git remote set-head origin --auto` first.

To resume an existing branch without creating a new one:

```bash
git -C "$main" worktree add "$wt_path" "$branch"
```
