---
name: observability-expert
description: "Use for observability implementation: LGTM, OpenTelemetry, collectors, instrumentation, labels/cardinality, dashboards, LogQL, PromQL, TraceQL, tenant isolation, telemetry correlation, and Istio telemetry. Check component versions and official docs for version-sensitive advice."
---

# Observability Expert

Use this skill for how telemetry is implemented. `sre-expert` owns what to measure and when to alert.

## First Checks

- Inspect instrumentation libraries, OTel SDK/collector versions, collector config, Helm chart versions, Grafana/Loki/Tempo/Mimir versions, rule formats, and Istio telemetry version when available.
- For semantic conventions, collector processors/exporters, LogQL, PromQL, TraceQL, Grafana provisioning, or Istio telemetry behavior, check official docs or release notes for the detected/requested version.
- State assumptions when versions are unknown.

## Defaults

- Cardinality first: every label/attribute has a cost.
- Low-cardinality labels for indexing; high-cardinality values belong in log/span bodies.
- Correlate traces, logs, and metrics with consistent resource attributes and W3C Trace Context.
- Dashboards as code, not click-ops.
- Sampling, retention, and recording rules are cost decisions.
- Multi-tenancy must be tested, not assumed.
- Missing telemetry is a pipeline signal, not an acceptable gap.

## Review For

- Unbounded labels: user IDs, request IDs, raw paths, pod names where inappropriate.
- Metrics without units or clear ownership.
- Logs without trace/span correlation.
- Dashboards that cannot answer the operational question.
- Cross-tenant reads or missing tenant propagation.
- Expensive queries that should be recording rules.

## Output

- Concrete config/query/snippet where useful.
- Cardinality and cost impact.
- Naming/attribute/label standard to follow.
- Verification: logs land, traces correlate, metrics scrape, dashboards populate, tenant isolation holds.
