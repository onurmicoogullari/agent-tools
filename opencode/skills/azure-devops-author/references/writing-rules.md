# Azure DevOps Writing Rules

## Clarify Only Blockers

Ask at most 1-3 questions when input is incomplete:

- Type: Feature or User Story
- Why: what problem this solves or unblocks
- Scope: what is included and deferred
- Done: concrete end state

Do not ask about iteration, assignee, tags, priority, or story points unless the user raises them.

## User Story Size Check

A User Story must fit within one 3-week sprint by one engineer or a pair. If too large, propose a split and wait.

Split by:

- workflow step
- component
- environment
- interface
- scope of inputs
- walking skeleton first

## Parent Rules

- Feature parent: existing Epic named by the user. Do not create Epics.
- User Story parent: existing Feature.
- Resolve parent title to ID through search and confirm the match.
- Never invent a parent ID.

## Title

- Action-oriented and specific.
- Sentence case.
- No trailing period.
- Avoid filler verbs like `Investigate`, `Look into`, `Discuss`.
- Use outcome verbs: `Specify`, `Decide`, `Migrate`, `Document`, `Validate`.

## Description

Use exactly these labels in this order:

1. `Background`: why this matters, current state, blockers, relevant consensus.
2. `Objective`: the concrete outcome.
3. `Scope`: included and explicitly deferred work.

Rules:

- Use inline bold labels, not headings, in Azure DevOps descriptions.
- No `As a / I want / so that` template.
- Do not restate the title.
- Do not repeat acceptance criteria.
- No legal/regulatory citations or named individuals.
- Reference only real ADO work items; describe not-yet-created work in prose.

## Acceptance Criteria

- Concrete, verifiable end states.
- Not activities.
- Prefer one strong artifact/end-state criterion over micro-step checklists.
- State only the observable conditions that must be true for the work item to be accepted.
- Never use negative acceptance criteria that describe something being absent, excluded, or not performed. Put a relevant delivery boundary under `Scope`; omit it when it does not help define the work.

Bad: `Discuss network segment with networking team.`

Good: `Network segment for the INFRADEV cluster is decided and documented.`

Bad: `Crossplane is not deployed in the observability cluster.`

Good: `Crossplane is installed and reconciled through GitOps in the target cluster.`

## Anti-Patterns

- Creating an Epic, Bug, or Task.
- Creating any item without a parent.
- Skipping collision scan.
- Auto-linking related items without asking.
- Claiming an item was created in manual fallback mode.
- Writing plain `#1234` in HTML fields.
- Using real headings in Azure DevOps description HTML.
