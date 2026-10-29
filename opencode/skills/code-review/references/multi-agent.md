# Multi-Agent Review

Use parallel read-only subagents only when the user explicitly asks or the scope spans independent high-risk domains and added coverage justifies the token and coordination cost. Examples include coordinated backend and infrastructure changes, authentication, data migrations, networking, stateful workloads, deployment systems, or large cross-service branches.

Keep the lead reviewer responsible for intent, desirability, synthesis, severity, and merge recommendation. Delegate only relevant, non-overlapping lanes, using the closest available agent type:

- **Backend and data:** runtime logic, APIs, concurrency, persistence, migrations, and integration contracts.
- **Infrastructure and platform:** IaC, Kubernetes, cloud resources, identity, networking, delivery, rollout, rollback, and operations.
- **Adversarial cross-cutting:** security, reliability, compatibility, negative paths, and shared assumptions.
- **Verification:** tests, static validation, observability, and whether safeguards exercise risky behavior. Add only when a fourth pass is justified.

Give every subagent the same resolved scope, base, intent, applicable repository instructions, and read-only boundary. Assign explicit responsibility and require only evidence-backed candidate findings containing priority, exact location, failure scenario, impact, minimal remedy, validation evidence, and confidence. Require a clear statement when no material issue is found.

Run independent lanes in parallel up to available capacity and wait for all requested results. Never use parallel review agents for concurrent edits.

Verify every candidate against the actual diff and surrounding code. Deduplicate by root cause, reconcile contradictions, lower severity when preconditions are weak, and discard speculative or out-of-scope claims. Agent agreement is not evidence. If subagents are unavailable, perform the relevant lanes sequentially without lowering the standard.
