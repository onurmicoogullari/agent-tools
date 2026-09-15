# Azure DevOps CLI Reference

## Preconditions

- `az boards --help` succeeds.
- `az account show` succeeds.
- `az devops configure --list` has the correct organization and `Datacenter` project, or can be configured.

Set defaults once if needed:

```bash
az devops configure --defaults organization=https://dev.azure.com/<org> project=Datacenter
```

## Useful Fields

- Acceptance criteria: `Microsoft.VSTS.Common.AcceptanceCriteria`
- Area path: `datacenter\\Application Platform`
- Description and acceptance criteria are HTML when written through the API.

## Collision Scan

Use 2-4 distinctive keywords. Filter to open Feature/User Story work under the Application Platform area.

```bash
az boards query --wiql "SELECT [System.Id], [System.WorkItemType], [System.Title], [System.State] FROM workitems WHERE [System.AreaPath] UNDER 'datacenter\\Application Platform' AND [System.WorkItemType] IN ('Feature','User Story') AND [System.State] <> 'Closed' AND [System.State] <> 'Done' AND [System.State] <> 'Removed' AND ([System.Title] CONTAINS '<keyword>') ORDER BY [System.ChangedDate] DESC" -o table
```

Classify matches as either collisions or related work. Ask before proceeding on collisions. Offer `related`, `predecessor`, or `successor` links for related work.

## Create And Update

```bash
az boards work-item create --type "User Story" --title "..." --area "datacenter\\Application Platform" --description "<p>...</p>"
az boards work-item update --id <id> --fields "Microsoft.VSTS.Common.AcceptanceCriteria=<ul><li>...</li></ul>"
az boards work-item relation add --id <child-id> --relation-type parent --target-id <parent-id>
```

Create, update acceptance criteria, and add links as separate confirmed operations.

## Link Types

| User intent | CLI relation type | Reference name |
|---|---|---|
| Parent | `parent` | `System.LinkTypes.Hierarchy-Reverse` |
| Related | `related` | `System.LinkTypes.Related` |
| Linked item must finish first | `predecessor` | `System.LinkTypes.Dependency-Reverse` |
| This item must finish before linked item | `successor` | `System.LinkTypes.Dependency-Forward` |
| Duplicate of existing item | `duplicate` | `System.LinkTypes.Duplicate-Forward` |

## Cross-References

Plain `#1234` does not auto-link when written through the API. Use an anchor:

```html
<a href="https://dev.azure.com/<org>/Datacenter/_workitems/edit/1234">#1234</a>
```

Resolve `<org>` from `az devops configure --list`, stripping `https://dev.azure.com/`.

## Do Not Set Unless Asked

- Iteration
- Assignee
- Tags
- Priority
- Story Points
