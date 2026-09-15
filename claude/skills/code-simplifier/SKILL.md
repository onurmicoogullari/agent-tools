---
name: code-simplifier
description: Simplify and refine existing code for clarity, consistency, and maintainability without changing its behavior. Use after code has been written or modified, or when asked to reduce complexity, duplication, nesting, or unnecessary abstraction. Focus on recently changed code unless the user requests a broader scope.
---

# Code Simplifier

<!--
Modification notice: This skill is a substantially revised derivative of an
upstream code-simplifier prompt. It was converted to a portable skill, and
provider-, model-, and stack-specific instructions were removed.
-->

Improve code structure while preserving externally observable behavior. Prefer
clear, explicit code over clever or compressed code.

## Establish the Contract

1. Identify the requested scope. When no scope is stated, use the current diff
   or other session evidence to find recently changed code.
2. Read applicable project instructions, configuration, tests, and nearby code
   before editing.
3. Identify behavior that must remain stable, including interfaces, outputs,
   errors, side effects, state transitions, ordering, timing, concurrency, data
   representation, and resource ownership where relevant.
4. Keep unrelated user changes intact. Do not broaden the edit unless a
   dependency must change to preserve correctness.

## Simplify

- Reduce unnecessary nesting, indirection, duplication, and accidental
  complexity.
- Clarify names, control flow, boundaries, and ownership.
- Consolidate closely related logic when it improves understanding.
- Separate unrelated responsibilities when their combination obscures intent.
- Remove dead code or redundant abstractions only when available evidence makes
  removal safe.
- Remove comments that merely restate the code. Preserve comments that explain
  rationale, invariants, constraints, or non-obvious edge cases.
- Follow the project's established conventions and local idioms.
- Prefer straightforward constructs to dense expressions or clever shortcuts.
- Preserve useful abstractions that improve organization, testing, reuse, or
  change isolation.

Do not introduce new features, dependencies, public interfaces, speculative
generalization, broad formatting churn, or architecture changes as part of a
simplification pass.

## Protect Behavior

- Do not hide control flow, errors, state changes, or side effects.
- Do not combine unrelated concerns merely to reduce line count.
- Do not weaken tests or alter expected results to accommodate changed
  behavior.
- Do not trade debuggability or extensibility for compactness.
- When several approaches are equally clear, prefer the one already used in
  the surrounding code.
- When evidence is insufficient to prove a removal or merge is safe, leave the
  code intact and report the opportunity instead.

## Verify

1. Inspect the final diff for accidental scope expansion or behavior changes.
2. Run the smallest relevant project checks for formatting, static analysis,
   compilation, and behavior.
3. Exercise affected edge cases, especially failure paths, empty and boundary
   inputs, ordering, state transitions, and concurrent behavior where relevant.
4. If full verification is unavailable, state exactly what was and was not
   checked.
5. Summarize only material refinements and any remaining risks.
