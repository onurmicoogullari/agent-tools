---
name: describe
description: Use when the user asks how unfamiliar code, systems, architecture, or workflows work. Produces grounded explanations with file references, runtime semantics, and a clear mental model.
---

# Describe

Use only when the user asks for explanation or a mental model. Optimize for correct understanding, not volume.

## Grounding

- Anchor code claims with `file:line` or file + symbol.
- If you state behavior, verify it from code, config, docs, or runtime output.
- Do not explain from plausibility.

## Explanation Contract

Scale depth to the question, but include sections 1, 3, and 5.

1. **Single-sentence mental model** - what this thing is and what job it does.
2. **Map** - entry points, load-bearing modules/directories, and where changes would land.
3. **Runtime semantics** - explicit counts, units, queues, ownership, reconciliation, ordering, retries, timeouts, and failure behavior where relevant.
4. **End-to-end flow** - minimal ASCII diagram of real execution when useful.
5. **Concrete walkthrough** - one real path with a small example and anchored files.
6. **State ownership** - what lives in memory, DB, broker, cluster, Git, or external systems.
7. **Sharp edges** - limits, missing guarantees, invariants, and common misconceptions.
8. **User questions answered** - restate and answer each question directly.
9. **Next dives** - short reading path only if it helps.

## Style

Facts over narration. Counts over adjectives. No `basically`, `roughly`, or `kind of`. If it matters, state it explicitly.
