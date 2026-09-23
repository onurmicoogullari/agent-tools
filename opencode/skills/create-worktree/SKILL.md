---
name: create-worktree
description: Use before making any file change in a git repository, or when creating a branch. Creates or resumes a sibling git worktree on its own branch, moves work into it, defines the branch naming rules, and cleans up finished worktrees.
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
  moving into it.
- Never switch a worktree to a different branch. Its directory name must keep
  matching its branch; create a new worktree instead.

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

If the repository's `AGENTS.md` defines its own branch naming, follow that
instead.

## Workflow

1. Check that the working directory is inside a git repository:
   `git rev-parse --is-inside-work-tree`. If it is not, skip this skill.
2. Check whether the current directory is a linked worktree. If
   `git rev-parse --git-dir` differs from `git rev-parse --git-common-dir`, it
   is. Keep working there if its branch matches the task. Otherwise, continue
   with step 3 and move to the right worktree.
3. Run `git worktree list`. If a worktree clearly matches the task, ask whether
   to resume it or create a new one. Also offer the cleanup described below,
   in one question, for any sibling worktree whose branch is finished.
4. Derive the branch name from the branch naming rules. Ask only when the
   prefix or description is unclear.
5. Create the worktree next to the main checkout. Name its directory
   `<repo>.<branch>`, with `/` in the branch replaced by `-`. For example,
   branch `fix/auth-timeout` in repository `app-platform` gets the directory
   `../app-platform.fix-auth-timeout`.
6. Move into the worktree. Run every later command, edit, and test from
   `$wt_path`, for example by setting each command's working directory to it.

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

## Cleanup

Remove a worktree when its branch is merged or abandoned. Only offer this for
sibling worktrees named `<repo>.<branch>`. Leave worktrees created by other
tools alone, such as `.claude/worktrees/` or `~/.codex/worktrees/`; those tools
clean up their own.

Ask before removing anything, and never remove a worktree with uncommitted
changes.

1. Do not remove the worktree you are working in. Move to the main checkout
   first.
2. Confirm the branch is finished: `gh pr view "$branch" --json state -q .state`
   prints `MERGED` or `CLOSED`, or the user says to discard it. If the branch
   has no pull request, only offer cleanup when the user asks.
3. Check for uncommitted work: `git -C "$wt_path" status --short`. If it prints
   anything, stop and ask.
4. Remove the worktree, then the branch:

```bash
git -C "$main" worktree remove "$wt_path"
git -C "$main" branch -D "$branch"
git -C "$main" worktree prune
```

Use `branch -D` only after confirming the pull request state. Squash and rebase
merges do not look merged to git, so `branch -d` would refuse.
