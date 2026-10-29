---
name: code-review
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

Keep reviews read-only. Local inspection and proportionate offline validation are allowed. Do not edit, commit, push, open pull requests, deploy, migrate data, mutate external systems, use configured credentials, or contact live environments unless the user explicitly includes that environment and action in scope.

When explicitly asked to fix findings, review first, make minimal in-scope fixes, validate them, and re-review the resulting diff. Do not commit, push, deploy, or apply infrastructure unless separately requested.

## Review in a Fresh Agent

A reviewer who wrote the change, knows the plan behind it, or has already discussed it reads the diff as intended instead of as written. Always run the review in a fresh read-only reviewer subagent, whoever wrote the change:

- Give it the resolved scope and base, the applicable repository instructions, the commit message and pull request description, and the read-only boundary. Do not give it the plan, later pull requests, design notes, the conversation, earlier review comments, suspected issues, or anyone's reasoning about the change. Tell it to follow this skill as the reviewer.
- Keep the lead role in the calling session: verify each candidate finding against the code, set severity, and deliver the review. Do not drop a candidate because the plan or the conversation explains it away; that explanation is exactly what the reviewer must not rely on.
- If you are the reviewer subagent, review directly. Do not start another reviewer agent.
- If no subagent is available, state that the review is not independent and apply every check in [Find What Authors Miss](#find-what-authors-miss) with extra care.

Never skip a review because the change looks small, mechanical, or like a workflow adjustment. A change that removes or loosens a check always gets a full review.

## Build Context

1. Read applicable `AGENTS.md` and repository instructions, including nested rules governing changed files.
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
3. **Scope:** Target, base or range, working-tree state, exclusions, and whether the review ran in a fresh agent.
4. **Verification:** Checks run and outcomes.
5. **Residual risk:** Unverified areas, assumptions, or safe post-merge follow-up.

If no finding qualifies, say `No material findings` and still report scope, verification, and residual risk. Keep clearly valuable optional improvements separate from findings; never invent an issue to make the review look useful.
