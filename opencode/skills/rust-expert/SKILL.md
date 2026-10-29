---
name: rust-expert
description: 'Use for Rust code: idioms, ownership and borrowing, lifetimes, errors, async, performance, tests, CLIs, kube-rs operators, public APIs, and Rust code review. Check Rust/crate versions and official docs for version-sensitive advice.'
---

# Rust Expert

Use this skill to apply Rust-specific judgment inside the current agent. Keep advice concrete, idiomatic, and project-aware.

## First Checks

- Inspect `Cargo.toml`, `Cargo.lock`, `rust-toolchain.toml`, edition, MSRV, features, and CI/tooling before version-specific advice.
- For Rust edition/compiler behavior or crate APIs such as Tokio, kube-rs, k8s-openapi, tracing, serde, or clap, check official docs or release notes for the detected/requested version.
- State assumptions when versions are unknown.

## Defaults

- Prefer straightforward, readable designs that minimize cognitive load and remain easy to change. Favor long-term maintainability over cleverness, premature abstraction, speculative genericity, and unnecessary optimization. Introduce complexity only when a demonstrated requirement justifies it.
- Make illegal states unrepresentable.
- Borrow when it keeps ownership simple; use owned values when they make APIs and control flow clearer or avoid unnecessary lifetime coupling.
- Prefer enums for closed sets, traits for behavior, newtypes over primitive obsession.
- Use `thiserror` for library errors, `anyhow` at application edges.
- Prefer the simplest readable idiom that preserves Rust's guarantees. Hide incidental complexity such as boxed futures, pinning, and object-safe async trait machinery behind a well-understood abstraction when it makes application code clearer; account for allocation, dispatch, and API-stability trade-offs.
- Avoid unexplained `unwrap`, `expect`, and `unsafe`; make panic invariants and soundness arguments explicit. Treat cloning and interior mutability as deliberate trade-offs, and prefer them when they materially simplify ownership or control flow without meaningful cost.
- For async applications, prefer the runtime already established by the project; use Tokio when no runtime is established and its ecosystem or capabilities fit the requirements. Do not impose a runtime on libraries unless the API genuinely requires one.
- Every spawned task has an owner and cancellation path.
- Never block the async runtime.

## Review For

- Lifetime design hiding ownership problems.
- Premature abstractions, excessive genericity, or optimizations without a demonstrated requirement or measurement.
- Overexposed lifetime, `Pin`, `Box<dyn Future>`, or other advanced machinery where a simpler, idiomatic abstraction would be easier to teach and maintain.
- Unnecessary clones or interior mutability.
- Missing `Send`/`Sync` bounds across `.await`.
- Panic paths in non-invariant code.
- Public APIs that make semver promises accidentally.
- kube-rs controllers that are not idempotent or lack status/finalizer handling.

## Output

- Recommendation and why it is idiomatic.
- Minimal code snippet when useful.
- Trade-offs and when another option fits better.
- Verification: tests, `cargo fmt`, clippy, doc-tests, proptest, benchmark, or flamegraph.
