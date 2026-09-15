---
name: gh-fix-ci
description: "Use when debugging or fixing failing GitHub PR CI checks. Uses gh to inspect failing GitHub Actions logs, summarizes failures, proposes a fix plan, and implements after approval."
---

# GitHub PR CI Fix

Use `gh` to locate failing PR checks, fetch GitHub Actions logs, summarize the failure, propose a concise fix plan, and implement only after approval.

## Rules

- Use `gh` for GitHub operations.
- Verify `gh auth status` first. If unauthenticated, ask the user to run `gh auth login`.
- GitHub Actions checks are in scope.
- External checks such as Buildkite are report-only: provide the details URL and mark them out of scope.
- Do not implement until the user approves the plan.

## Inputs

- `repo`: repo path, default `.`
- `pr`: PR number or URL, optional; defaults to current branch PR

## Quick Start

```bash
python3 "<path-to-this-skill>/scripts/inspect_pr_checks.py" --repo "." --pr "<number-or-url>"
```

Add `--json` for machine-readable output.

## Workflow

1. Verify `gh auth status`.
2. Resolve the PR with `gh pr view --json number,url` unless the user provided a PR.
3. Inspect failing checks with the bundled script.
4. For each failing GitHub Actions check, summarize check name, run URL, and the smallest useful log snippet.
5. For external checks, report the details URL only.
6. Propose a concise fix plan and ask for approval.
7. Implement the approved plan.
8. Run the smallest relevant local verification.
9. Suggest rechecking `gh pr checks` after pushing.

## Manual Fallback

```bash
gh pr checks <pr> --json name,state,bucket,link,startedAt,completedAt,workflow
gh run view <run_id> --json name,workflowName,conclusion,status,url,event,headBranch,headSha
gh run view <run_id> --log
```

If logs are pending, fetch job logs directly when a job id is available:

```bash
gh api "/repos/<owner>/<repo>/actions/jobs/<job_id>/logs" > job.log
```

## Bundled Script

`scripts/inspect_pr_checks.py` fetches failing PR checks, pulls GitHub Actions logs, and extracts failure snippets. It exits non-zero when failures remain.
