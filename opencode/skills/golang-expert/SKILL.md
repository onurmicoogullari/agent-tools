---
name: golang-expert
description: 'Use for Go code: idioms, package design, concurrency, errors, performance, tests, CLIs, services, Kubernetes operators, and Go code review. Check Go/module versions and official docs for version-sensitive advice.'
---

# Go Expert

Use this skill to apply Go-specific judgment inside the current agent. Keep advice concrete, idiomatic, and project-aware.

## First Checks

- Inspect `go.mod`, `go.work`, generated-code versions, dependency versions, and CI/tooling before version-specific advice.
- For Go version, stdlib behavior, `controller-runtime`, `client-go`, `sqlc`, `pgx`, or OpenTelemetry APIs, check official docs or release notes for the detected/requested version.
- State assumptions when versions are unknown.

## Defaults

- Prioritize correctness and security, then simplicity and long-term maintainability, idiomatic Go, sound repository consistency, and finally personal preference.
- Prefer explicit, unsurprising code over clever abstractions. Avoid premature abstraction, speculative generalization, and unnecessary indirection.
- Prefer the standard library and minimize dependencies and exported API surface.
- Follow established repository conventions when they are sound. Do not reproduce patterns that compromise correctness, security, clarity, maintainability, or idiomatic Go.
- Keep necessary departures from repository conventions scoped and explain them. Recommend gradual migration when broader cleanup is warranted.
- Before making a breaking change, ask whether backward compatibility is required, unless the user has already stated the compatibility requirement.
- Prefer cohesive packages with clear responsibilities, usually organized by domain. Avoid both monolithic packages and needless fragmentation.
- Introduce small interfaces at consumer boundaries when substitution is genuinely needed. Treat accepting interfaces and returning concrete types as a guideline, not a mechanical rule.
- Every goroutine has ownership, cancellation, and shutdown.
- Bounded concurrency by default.
- Errors are wrapped with caller-useful context; panic only for invariants.
- Context propagates through service boundaries.
- Production code includes graceful shutdown, config validation, logs, metrics, traces where relevant.

## Review For

- Goroutine leaks, unbounded work, data races, channel misuse.
- Error swallowing or context-free errors.
- Over-mocking instead of boundary tests.
- Performance claims without benchmarks or profiles.
- Complexity, abstraction, or indirection without a concrete benefit.
- New code that perpetuates harmful repository patterns.
- Unnecessary exported APIs, dependencies, or compatibility breaks.
- Opportunistic refactoring that expands the requested change without sufficient benefit.
- Operator reconciliation that is not idempotent or lacks status/finalizer handling.

## Output

- Recommendation and why it is idiomatic.
- Minimal code snippet when useful.
- Trade-offs and when another option fits better.
- Call out intentional departures from repository conventions and explain why.
- Separate improvements required for the current change from broader cleanup recommendations.
- Verification: tests, `go test`, race detector, vet/lint, benchmark, or pprof.
