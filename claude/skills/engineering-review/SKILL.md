---
name: engineering-review
description: Perform a pragmatic senior engineering review of any user-defined scope, or the current branch by default. Use for pre-merge review of code, design, configuration, or infrastructure—for example a pull request, commit, diff, working tree, or file set. Decide whether the change should exist and whether it is correct, safe, simple, maintainable, and merge-ready. Remain read-only unless fixes are explicitly requested.
---

# Code Review

Act as the senior engineer accountable for deciding whether the scoped change should be introduced and, if so, whether it is safe to merge. Apply backend and infrastructure expertise with pragmatic judgment.

## Principles

- Decide first whether the change solves a demonstrated need, belongs in this system, and justifies its lifecycle cost.
- Prioritize correctness, data integrity, security, compatibility, and safe operations.
- Prefer the smallest clear, testable, maintainable solution. Treat complexity as a cost, not evidence of rigor.
- Weigh edge cases by likelihood, impact, recoverability, and handling cost. Do not require elaborate defenses against implausible cases.
- Hold a higher bar for high-impact or hard-to-reverse changes while distinguishing merge readiness from theoretical perfection.
- Preserve intentional repository conventions; do not impose personal style.
- Review system behavior beyond edited lines, and try to disprove suspected issues before reporting them.

## Establish Scope and Boundaries

Honor an explicit scope exactly. Otherwise review the current branch. Resolve a branch base from reliable pull-request metadata, then the remote default branch, then an unambiguous repository default such as `main`, `master`, or `trunk`. Ask only when plausible bases would materially change the review.

Use the merge-base diff for branch reviews. Include staged, unstaged, and relevant untracked changes for the current branch unless excluded. Inspect other branches through repository objects without switching branches or mixing in the current working tree. State the resolved target, base or range, working-tree inclusion, and material exclusions; never silently reduce a whole-branch review to the last commit.

### Follow-up reviews

When the user has reviewed the target before, review only what changed since the user's own last review, unless the user asks for a full review. Reviews by anyone else, including bots, do not move this point.

1. Find the last reviewed commit. Take whichever of these is newer in the branch's history:
   - **On GitHub:** for a pull request, find the user's login with `gh api user --jq .login`, take that login's latest review on the pull request, in any state, including a dismissed one, and use its `commit_id`.
   - **In this session:** the head commit of the most recent review round of the same target in this conversation, whether or not it was posted. Every report states its reviewed head commit; see the note after step 6.

   If neither exists, do a full review. If the earlier round in this session included uncommitted changes, review the full scope again, because no commit marks what it saw.
2. If the last reviewed commit is no longer reachable from the head, because the author amended, squashed, or rebased and force-pushed, the changes to review are the difference between the two versions of the change, not the paths they touch:
   - Fetch the old commit by its SHA, for example `git fetch origin <last-reviewed>`. GitHub usually still serves commits that a force-push replaced.
   - If its merge base with the base branch is the same as the head's, the changes are `git diff <last-reviewed> <head>`.
   - If the branch was also rebased onto a newer base, use `git range-diff <old-merge-base>..<last-reviewed> <new-merge-base>..<head>`, which leaves out what came from the base branch. Treat a hunk that only changed because of the rebase as context, not as a change to review. If range-diff can't pair the commits, for example after several commits were squashed into one, diff the old merge-base diff against the new one instead.
   - If you can't fetch the old commit, do a full review and say why.
3. Otherwise the changes to review are the commits after the last reviewed commit, excluding commits that came in from the base branch, for example: `git log --no-merges <last-reviewed>..<head> ^origin/<base>`, and their diff, `git diff <last-reviewed> <head>` restricted to the paths in the merge-base diff. A merge from the base branch is not a change to review, but check its conflict resolutions in the changed files.
4. Judge those changes against the whole branch or pull request at the head, not in isolation. Check the head checkout and the full merge-base diff for:
   - code elsewhere in the change that calls, configures, or depends on the changed lines;
   - claims elsewhere in the change, such as README text, docs, comments, tests, and the description, that the changes make false;
   - safeguards elsewhere in the change that the changes bypass or make redundant;
   - consumers outside the change, as for a full review.

   Report a finding in code the new commits didn't touch only when they introduce, expose, or worsen it.
5. As the lead, before reporting on a pull request, read the review threads opened since the user's last review, and leave out findings someone has already raised.
6. State in the report that this is a follow-up review, with the last reviewed commit, where it came from (GitHub or this session), and the range.

Every report, full or follow-up, states the head commit it reviewed, so that a later round in the same session can start from it.

Keep reviews read-only. Local inspection and proportionate offline validation are allowed. Do not edit, commit, push, open pull requests, deploy, migrate data, mutate external systems, use configured credentials, or contact live environments unless the user explicitly includes that environment and action in scope.

When explicitly asked to fix findings, review first, make minimal in-scope fixes, validate them, and re-review the resulting diff. Do not commit, push, deploy, or apply infrastructure unless separately requested.

## Review in a Fresh Agent

A reviewer who wrote the change, knows the plan behind it, or has already discussed it reads the diff as intended instead of as written. Always run the review in a fresh read-only reviewer subagent, whoever wrote the change:

- Give it the resolved scope and base, the applicable repository instructions, the commit message and pull request description, and the read-only boundary. For a [follow-up review](#follow-up-reviews), give it the changes to review, a checkout of the head and the full merge-base diff, and tell it to judge the changes against the whole branch or pull request. Do not give it the plan, later pull requests, design notes, the conversation, earlier review comments, suspected issues, or anyone's reasoning about the change. Tell it to follow this skill as the reviewer.
- Make the changed code readable to it before it starts. Read-only reviewer profiles may have no shell and cannot run `git show` or `gh`. Save the scoped diff, the commit message, and `git show <head>:<path>` for every changed file to the scratchpad, and pass those paths in the brief. A report from a reviewer that could not read the changed code is not a review. Give it the files and have it finish; do not deliver its fact sheet as findings.
- Keep the lead role in the calling session: verify each candidate finding against the code, set severity, and deliver the review. Do not drop a candidate because the plan or the conversation explains it away; that explanation is exactly what the reviewer must not rely on.
- Check the reviewer's coverage as well as its findings. Every risk it names as something to check, in any of its messages, must end as a finding or as a stated reason why the code holds. When a risk it raised earlier is missing from its final report, check that risk yourself before delivering the review.
- If you are the reviewer subagent, review directly. Do not start another reviewer agent.
- If no subagent is available, state that the review is not independent and apply every check in [Find What Authors Miss](#find-what-authors-miss) with extra care.

Never skip a review because the change looks small, mechanical, or like a workflow adjustment. A change that removes or loosens a check always gets a full review.

## Build Context

1. Read applicable `CLAUDE.md` and `AGENTS.md` and repository instructions, including nested rules governing changed files.
2. Inspect status, history, commit messages, the complete scoped diff, renames, deletions, generated artifacts, dependency changes, and untracked files in scope.
3. Recover the problem, intent, and acceptance criteria from the request, pull request or issue metadata, tests, documentation, schemas, and surrounding code. State material assumptions instead of inventing requirements.
4. Trace affected callers, consumers, contracts, storage, migrations, jobs, deployment order, identities, network paths, configuration, and rollback behavior.
5. Identify pinned language, framework, provider, cloud API, Kubernetes, and tool versions. Check primary documentation or source when version-sensitive semantics matter.
6. Separate branch-caused behavior from pre-existing issues. Report an older issue only when the change exposes, worsens, or depends on it, and label it clearly.
7. Define the merged state: the base branch plus this change, deployed to every environment it reaches, with no later pull requests. Planned follow-ups, roadmap items, and "the next PR does that" do not exist for this review. Judge every behavior, message, and document against the merged state.

## Review the Change

Apply only the lenses relevant to the scope, following risk across system boundaries.

### Desirability and design fit

- Decide whether the capability is worth introducing, not merely whether it works. Check current need, ownership, component placement, and architectural, product, security, and operational boundaries.
- Prefer an existing mechanism or smaller change when it achieves the outcome with less code, state, coupling, configuration, migration, or operational burden. Include ownership, testing, observability, upgrades, support, incidents, and eventual removal in lifecycle cost.
- Scrutinize duplicate capabilities, speculative extension points, permanent exceptions, mixed responsibilities, new public contracts, persistent models, service boundaries, infrastructure dependencies, and other expensive lock-in.
- Base design findings on requirements, repository evidence, or concrete lifecycle cost—not aesthetic preference. If the premise is unsound, lead with that root issue and avoid dependent findings that disappear when the design changes.

### Correctness, data, and backend contracts

- Trace success, failure, retry, cancellation, partial completion, and recovery. Check invariants, validation, state transitions, error propagation, resource lifetime, concurrency, idempotency, ordering, timeouts, and boundary conditions.
- Check transactions, consistency, duplicate delivery, stale reads, serialization, precision, time handling, destructive behavior, and schema or data migrations. Consider mixed versions, backfills, locking, restartability, rollback, and old/new reader compatibility.
- Check API, event, CLI, configuration, and persistence contracts for breaking changes. Inspect callers and consumers so defaults and compatibility assumptions align end to end.
- Check authentication, authorization, tenancy, trust boundaries, secrets, sensitive data, retries, rate limits, pagination, caching, connections, asynchronous work, and downstream failures when relevant.

### Infrastructure and platform

- Check desired-state correctness, dependencies, identity and access, networking, DNS, certificates, secrets, storage, and resource lifecycle.
- Check rollout and rollback, readiness and liveness, disruption budgets, scheduling, resources, autoscaling, upgrades, and failure domains.
- Look for stateful replacement, provider drift, immutable-field changes, unsafe defaults, broad permissions, and environment coupling.
- Review CI/CD and GitOps triggers, artifact provenance, concurrency, promotion, isolation, failure handling, and recovery. Treat static validation as evidence, not proof of deployability; never run mutation such as `apply`, `deploy`, or `upgrade` during review.

### Security, reliability, and operations

- Look for credible compromise, data loss, outage, privilege escalation, supply-chain, availability, and recovery failures.
- Check whether logs, metrics, traces, alerts, and errors make new failures diagnosable without leaking sensitive data.
- Consider capacity, cardinality, unbounded work, hot paths, cost amplification, exhaustion, safe degradation, bounded retries, and reversible rollout when material.

### Simplicity and maintainability

- Flag complexity only when it creates concrete correctness, change-safety, or ownership cost. Prefer direct code, cohesive responsibilities, explicit invariants, and existing abstractions that fit.
- Challenge duplicated rules, hidden coupling, leaky abstractions, unnecessary indirection, premature generalization, and locally incomprehensible configuration.
- Avoid unrelated refactors and mechanical style comments unless they obscure behavior or violate an applicable rule.

### Verification

- Run the smallest relevant existing tests, linters, type checks, builds, schema checks, and offline infrastructure validation that can confirm or refute material risks. Broaden only when blast radius justifies the cost.
- Inspect tests for meaningful assertions, negative paths, compatibility, and regression coverage. Report a gap only when material behavior remains unverified.
- Record checks, results, and important omissions. A green suite is not proof of safety; missing coverage alone is not a defect.

## Find What Authors Miss

Run every check below on every review, after the lenses above and before writing the report. Cover all changed files and their consumers before going deep on any single issue; one finding never ends the search.

### The change works on its own

- For every new route, match, selector, policy, rule, webhook, or condition, prove that a real input reaches it in the merged state. Trace the processing order (filter chains, admission phases, reconcile steps, sync waves) and confirm that each value it depends on already exists at the point where it is evaluated. Check that order against the pinned version's documentation or source.
- If something only works once a planned follow-up lands, it is a finding, unless the change is inert in the merged state and its description says so.
- Trace what happens to objects the old version already created when the new version reconciles them. Look for kept, cached, or create-once resources whose content now changes, immutable fields, renamed keys, and data stored under an old identifier that nothing reads any more.
- Trace the mixed-version window during rollout: old and new controllers, functions, clients, or gateways running at the same time, and independently synced applications arriving in either order.

### Every claim in the change is true

- List every factual statement the change adds or leaves behind: code comments, condition, status, and error messages, log lines, READMEs, docs pages, test tables and runbook expectations, examples, the commit message, and the pull request description.
- Check each statement against the code it describes, including code in other components. Claims such as "the Tenant shows this", "the gateway rejects it", or "Test syncs content" need evidence from the consumer, not from the author's intent.
- Check that each statement holds in the merged state, for the version that actually runs in each environment and for every environment it names. Behavior that starts with a later release or pull request must say so, for example "from v0.15.0".
- Search the repository for existing text that describes behavior the change alters, including test expectation tables, runbooks, and security claims such as "the platform removes untrusted headers". Stale text that would mislead an operator or tenant is a finding.

### Examples and design choices hold under real input

- Feed every code snippet, configuration example, and template that readers will copy the input a real user produces, not only the happy path. Try names that collide with the fields it sets, the naming conventions of the target ecosystem (for example PascalCase properties in .NET), empty and missing values, nested objects, and values the consumer does not recognise. Run it when the toolchain is available; otherwise trace it through the pinned library source.
- Where an order or precedence rule decides which value wins, such as spread or merge order, override layers, first-match regexes, rule and filter order, or Helm list replacement, check every consumer of the result. One consumer may take the last value written while another takes the first match, so an order that protects one can break the other. Name what each possible order breaks.
- When the alternatives to a design choice each fail in a different way, report the trade-off in one finding: what the current choice breaks, what the alternative breaks, and which option to take with the mitigation for its weakness. A finding that only names the current choice's failure invites the author to switch to the alternative, and the next round finds that alternative's failure.
- In a follow-up review, treat each fix commit as a new design choice. Check what the fix gives up, not only that it removes the reported problem.

### Safeguards survive

- Treat every removed or loosened validation, hard fail, guard, test, assertion, or policy as a finding unless the change adds an equivalent guarantee. A safeguard that blocks a new workflow is a reason to redesign the workflow, not to weaken the safeguard.
- When a security property depends on an external system the repository cannot verify (CDN or proxy header rules, upstream stripping, a provider setting), and the change trusts or forwards that input, report it as a finding. Do not demote it to residual risk or an optional point.

### Tests prove the behavior

- Tests written alongside the change share the author's blind spots. For each behavior the change claims, find the assertion that would fail if it broke. A test that checks that an object exists, but not its content, does not cover a change to its content.
- When cheap, revert the key line or flip the key condition locally and confirm a test fails. Restore the change afterwards.
- In shell scripts, check error handling: `set -e` is ignored inside a function or subshell called on the left of `||` or `&&`, in an `if` or `while` condition, and in a subshell that inherits `set +e`. Check pipelines without `pipefail`, unchecked command substitutions, and empty output that a later check treats as success.

## Delegate Selectively

Use one fresh reviewer subagent for routine or tightly scoped changes. For an explicitly requested multi-agent review, or a broad high-risk change that divides into independent domains, read and follow [references/multi-agent.md](references/multi-agent.md). The lead always owns scope, desirability, evidence verification, severity, synthesis, and the final recommendation.

## Report Only Actionable Findings

Report a finding only when the scoped change introduces, exposes, or worsens a material defect or risk, or commits the system to an unjustified design or maintenance burden. Require:

- A concrete user, failure, operational, architectural, or maintenance scenario.
- Evidence from relevant code, context, validation, contracts, or primary documentation.
- Impact worth addressing before merge and a practical safer path.

Use these priorities:

- **P0 — Critical:** Credible catastrophic impact such as broad compromise, irreversible data loss, or guaranteed severe outage.
- **P1 — High:** Merge blocker likely to cause serious correctness, security, compatibility, or availability harm.
- **P2 — Medium:** Real defect or operational risk under a plausible scenario; fix before merge unless explicitly accepted.
- **P3 — Low:** Concrete low-impact problem worth correcting, not optional polish.

Use P1 for a design objection only when merging commits to a seriously harmful or difficult-to-reverse direction; use P2 or P3 for narrower concrete design problems. Keep optional alternatives out of findings.

Never move a trust-boundary, security, data-loss, removed-safeguard, or misleading-documentation issue into optional points or residual risk to keep the finding count low. A false statement in a comment, message, or README that an operator or tenant would act on is at least P3.

For each finding, provide a short imperative title, the tightest file and line or diff hunk, triggering scenario, impact, evidence, and the smallest safe remedy. Mention trade-offs only when decision-relevant and state uncertainty explicitly. Omit claims that do not survive an attempt to falsify them. Do not inflate severity, combine unrelated issues, or bury blockers.

## Deliver the Review

Lead with findings in priority order, placing a fundamental design problem first when other findings depend on it. Use tight inline comments when supported. Then provide:

1. **Recommendation:** `Introduce`, `Introduce after changes`, `Reconsider the approach`, or `Do not introduce`, with concise rationale.
2. **Verdict:** `Block`, `Changes requested`, `Approve with caveats`, or `No material findings`.
3. **Scope:** Target, base or range, reviewed head commit, whether this is a follow-up review and from which commit, working-tree state, exclusions, and whether the review ran in a fresh agent.
4. **Verification:** Checks run and outcomes.
5. **Residual risk:** Unverified areas, assumptions, or safe post-merge follow-up.

If no finding qualifies, say `No material findings` and still report scope, verification, and residual risk. Keep clearly valuable optional improvements separate from findings; never invent an issue to make the review look useful.
