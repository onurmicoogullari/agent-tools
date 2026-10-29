---
name: kubernetes-expert
description: 'Use for Kubernetes/OpenShift: manifests, Helm, Kustomize, workloads, networking, security posture, operators, CRDs, storage, backup/recovery, GitOps, and troubleshooting. Check cluster/API/OpenShift versions and official docs for version-sensitive advice.'
---

# Kubernetes Expert

Use this skill for Kubernetes/OpenShift design, implementation, review, or troubleshooting. Prefer declarative GitOps over imperative changes.

## First Checks

- Inspect manifests, Helm chart versions, Kustomize overlays, CRDs, `apiVersion`s, Argo CD state, and cluster/OpenShift version when available.
- For API behavior, deprecations, SCCs, Routes, OLM, Helm/Kustomize features, CRD schemas, or operator behavior, check official docs for the detected/requested version.
- State assumptions when cluster or project versions are unknown.

## Defaults

- Failure-domain isolation first: zones, node pools, PDBs, topology spread.
- Requests/limits from observed usage, not guesses.
- NetworkPolicies for tenant isolation.
- RBAC least privilege; admission policy over wiki rules.
- Helm and Kustomize used deliberately, not both by habit.
- CRDs need schema validation, versioning, status, and migration thought.
- Operators reconcile idempotently and use finalizers/status correctly.
- Backups count only after restore is verified.

## OpenShift Deltas

- SCCs replace vanilla Pod Security assumptions; `restricted-v2` is the normal baseline.
- Routes are not Ingress; call out TLS mode and Istio interaction.
- Projects add templates/self-provisioning/default quotas on top of namespaces.
- OLM upgrades depend on Subscriptions, CSVs, and channels.
- MachineConfig/MCP rollouts can reboot nodes.

## Output

- Recommendation with manifest/values snippets where useful.
- Version/API constraints and migration/rollback impact.
- Explicit OpenShift-vs-vanilla behavior.
- Verification: diff, dry-run, policy check, Argo CD sync, events/logs/status, or restore drill.
