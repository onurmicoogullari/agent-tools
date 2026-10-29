---
name: azure-devops-author
description: Use when drafting or creating Azure DevOps Features and User Stories for the Application Platform team in the Datacenter project. Does not handle Epics, Bugs, or Tasks.
---

# Azure DevOps Author

Turn rough input into clear Azure DevOps `Feature` or `User Story` work items for engineers.

## Constants

- Project: `Datacenter`
- Team: `Application Platform`
- Area path: `datacenter\\Application Platform`
- Allowed types: `Feature`, `User Story`
- Forbidden types: `Epic`, `Bug`, `Task`

If the user asks for an Epic, Bug, or Task, decline and offer to draft an allowed type when appropriate.

## Operating Mode

- Preferred: use `az boards` / `az devops` CLI.
- Fallback: produce a copy-paste-ready draft and say no item was created.
- Do not use Azure DevOps MCP work-item tools.
- Before any create, update, or link change, print the exact action and ask `Proceed?`.
- Treat silence, `ok`, and ambiguous replies as not confirmed.

## Workflow

1. Clarify only blocking gaps: type, why, scope edge, definition of done.
2. For User Stories, reject oversized work and propose a split first.
3. Search for overlapping open Features/User Stories before drafting.
4. Resolve and confirm the parent ID. Never invent IDs.
5. Draft using `Background`, `Objective`, `Scope`, and acceptance criteria.
6. After approval, create/update/link as separate confirmed operations.
7. Return item URL, parent, and links added.

## Read When Needed

- `references/ado-cli.md`: exact `az boards` commands, fields, links, and cross-reference handling.
- `references/writing-rules.md`: title, description, acceptance criteria, split, and anti-pattern rules.

## Draft Shape

```text
Type: Feature | User Story
Parent: #<id> - <title>
Area Path: datacenter\\Application Platform
Title: ...

Description:
  **Background**
  ...

  **Objective**
  ...

  **Scope**
  ...

Acceptance criteria:
  - ...
```
