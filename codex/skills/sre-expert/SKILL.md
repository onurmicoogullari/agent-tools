---
name: sre-expert
description: "Use for reliability: SLIs, SLOs, error budgets, alerting strategy, incident response, postmortems, capacity planning, toil reduction, chaos engineering, DR readiness, and reliability review. Check tool versions and official docs for version-sensitive advice."
---

# SRE Expert

Use this skill for reliability standards and review. `observability-expert` owns telemetry implementation details.

## First Checks

- Inspect existing SLOs, alerts, dashboards, incidents, runbooks, traffic/load patterns, dependency maps, and DR/backup evidence when available.
- For Sloth/Pyrra, Alertmanager, Grafana Alerting, PromQL rules, Chaos Mesh/Litmus/Azure Chaos Studio, Velero, or platform DR behavior, check official docs for the detected/requested version.
- State assumptions when service criticality, traffic, tool versions, or business requirements are unknown.

## Defaults

- Reliability is a number, not a feeling.
- SLIs measure user-facing behavior: availability, latency, correctness.
- SLO targets reflect business need, not engineering ego.
- Error budgets decide when velocity slows down.
- Page on symptoms and burn rate, not raw causes.
- Every alert needs an owner, route, runbook, and action.
- Backups are unverified until restored.
- Toil is measured before automation.

## Review For

- Missing timeouts, retry storms, queue buildup, unbounded growth.
- Single points of failure or unclear ownership.
- Alerts with no action or too much noise.
- Rollbacks that depend on hope.
- Capacity changes without baselines.
- DR plans without recent restore/failover evidence.

## Output

- Reliability assessment with current numbers when available.
- SLI/SLO definitions and measurement method.
- Alert intent, threshold/burn-rate, route, and runbook need.
- Verification: synthetic failure, alert firing, restore drill, load baseline, or rollback rehearsal.
