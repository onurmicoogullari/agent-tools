---
name: pr-review
description: Use when the user asks to review a GitHub pull request by number, URL, or branch. Renames the session, builds a mental model of the change, runs an independent engineering review, and drafts review comments that are posted only after approval.
argument-hint: '[PR number, URL, or branch]'
---

# PR Review

Help the user understand a pull request first, then review it independently, then turn the findings into review comments. Run the steps in order and finish each one before starting the next.

Stay read-only until the user approves posting in step 6. Do not check out the pull request over the user's working tree, edit files, push, or change the pull request.

## 1. Resolve the pull request

Accept a number, URL, or branch. Without one, use the pull request for the current branch. If none exists or the input is ambiguous, ask.

```bash
gh pr view <pr> --json number,url,title,body,author,state,isDraft,baseRefName,headRefName,headRefOid,closingIssuesReferences,additions,deletions,changedFiles
```

Add `--repo <owner>/<repo>` when the pull request belongs to another repository. Fetch the head commit without switching branches, for example `git fetch origin pull/<number>/head`. Pin every later step to `headRefOid`, so explanations, the review, and permalinks describe the same commit even if the author pushes again. If a new commit arrives before posting, say so and ask whether to re-run the review.

## 2. Rename the session

Set the session title to `(review): <headRefName>`, for example `(review): feat/tenant-quotas`. In the Claude desktop app, use the session title tool with `self` as the session. If no such tool is available, state the title in one line and continue.

## 3. Gather context

Collect what the author and other reviewers have already said:

- **Intent:** the pull request description and every linked issue or work item you can read, including Azure DevOps `AB#` links. Do not guess the content of items you cannot open.
- **CI:** `gh pr checks <pr>`. Note failing, pending, and skipped checks.
- **Discussion:** existing reviews, review threads, and comments, for example `gh pr view <pr> --comments` and `gh api repos/<owner>/<repo>/pulls/<number>/comments`. Note which threads are unresolved.

Use this context for the mental model and for step 6. Keep the discussion out of the independent review in step 5.

## 4. Build the mental model

Explain what the pull request changes and how, following the `describe` skill's explanation contract and grounding rules. Anchor claims in the head commit with `file:line`. Adapt the contract to a change:

1. **The change in one sentence:** what the pull request does and why.
2. **Intent versus implementation:** what the description and linked items promise, what the code actually does, and any gap between the two.
3. **Map:** changed files grouped by role, with a suggested reading order. Call out generated files, renames, deletions, and dependency changes.
4. **Before and after:** the behavior on the base branch and on the head commit. Add a short diagram when the flow is not obvious.
5. **Concrete walkthrough:** one real path through the new code with a small example.
6. **Where to look closely:** the parts that carry the most risk or are hardest to follow, without judging them yet.
7. **Status:** CI results and the open discussion threads that matter.

Scale the depth to the size of the change. A ten-line fix needs sections 1, 2, and 5; a new subsystem needs all seven.

## 5. Checkpoint, then review

End the turn after the mental model. Ask whether the user has questions or is ready for the review. Answer questions until the user says to continue.

Then follow the `engineering-review` skill for the head commit, with its merge base on `baseRefName` as the base. Its follow-up rules decide whether to review the whole pull request or only the changes since the user's last review. That skill runs the review in a fresh reviewer agent. Give the reviewer only what it allows: the scope, the repository instructions, the commit messages, and the pull request description. Do not pass the mental model, the user's questions, this conversation, or the existing review discussion; they would make the reviewer read the change as intended instead of as written.

Deliver the review as `engineering-review` specifies.

## 6. Draft review comments

Ask which findings to turn into comments. Default to every finding the user does not dispute.

Draft the comments by following the "PR Review Comments" section of `CLAUDE.md`:

- Put each finding in an inline comment on the tightest changed line of the head commit. A finding that cannot be anchored to a line in the diff goes in the review body.
- Skip a finding that an existing thread already raises. Mention it in the review body only if that thread is still unresolved and blocking.
- Keep the review body to a few sentences, or leave it empty when the inline comments say enough.
- Choose the review type: `REQUEST_CHANGES` when any finding should block merge, otherwise `COMMENT`. Use `APPROVE` only when the user asks. GitHub rejects `REQUEST_CHANGES` on your own pull request; use `COMMENT` when `gh api user --jq .login` matches the author.

Show the whole draft: review type, body, and each comment with its file and line. Post only after the user approves this draft. Post it as one review pinned to the head commit:

```bash
gh api repos/<owner>/<repo>/pulls/<number>/reviews --method POST --input review.json
```

```json
{
  "commit_id": "<headRefOid>",
  "event": "REQUEST_CHANGES",
  "body": "<review body>",
  "comments": [
    { "path": "src/app.go", "line": 42, "side": "RIGHT", "body": "<comment>" }
  ]
}
```

Write `review.json` to a temporary directory. Report the URL of the posted review.
