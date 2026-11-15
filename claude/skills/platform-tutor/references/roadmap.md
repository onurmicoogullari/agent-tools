# Learning roadmap

This is the order in which the learner works through the platform, from new
to tech to junior platform engineer. Use it to answer "what should I learn
next?", to name what a topic builds on, and to suggest next topics. Don't
refuse to explain a topic because it comes later in the list. Explain it, and
mention what it builds on.

The goal is that he can take a normal team ticket, plan it, make the change,
test it, open the PR, follow it through Argo CD to the cluster and explain his
choices to a reviewer, with support but without someone guiding every step.

Each part ends with a checkpoint. He passes it by explaining the topic and
doing the task without AI help.

## 1. Ways of working

1. Terminal basics: moving between folders, pipes, environment variables, running scripts.
2. Git and GitHub: branches, commits, rebasing, PRs and reviews, and the team's conventions in `AGENTS.md`.
3. YAML: maps, lists, indentation, files with several documents.
4. Working with AI tools: ask for an explanation before asking it to act, check its claims, read every diff, and never run a command against a cluster without understanding it.
5. First PR: a docs fix in `docs/platform/` with CI passing.

Checkpoint: he gets a PR merged without help.

## 2. Networking

6. IP addresses: subnets, private and public addresses, NAT.
7. Ports, TCP and UDP: what a connection is and what the handshake does.
8. DNS: record types, how a name gets resolved, TTL, internal and public DNS.
9. HTTP: methods, headers, status codes, the Host header.
10. TLS and certificates: encryption, certificate authorities, certificate chains, SNI, expiry.
11. mTLS: both sides prove who they are.
12. Firewalls: allow lists, network zones such as the DMZ, how firewall openings get requested.
13. Load balancers and reverse proxies: layer 4 and layer 7, health checks, where TLS is terminated; F5 and Akamai.

Checkpoint: he explains what happens from typing a URL into a browser until the page loads, with TLS included.

## 3. Containers and Kubernetes, in depth

14. Images and registries: layers, tags and digests, the platform's registry cache.
15. Core objects, hands-on: Pod, Deployment, ReplicaSet, Service, ConfigMap, Secret, namespace.
16. Health and resources: health probes, resource requests and limits, restarts and out-of-memory kills.
17. Scheduling: nodes, taints and tolerations, topology spread constraints.
18. Storage: PersistentVolumes, PersistentVolumeClaims, StorageClasses, StatefulSets.
19. Kubernetes networking: Service types, DNS inside the cluster, NetworkPolicy.
20. Access control: ServiceAccounts, Roles, RoleBindings.
21. What OpenShift adds: Projects, Routes, security context constraints, the web console, the `oc` CLI.
22. Troubleshooting: `describe`, logs and events; `Pending`, `ImagePullBackOff`, `CrashLoopBackOff`.

Checkpoint: he finds out on infradev why a Pod that someone deliberately broke won't start.

## 4. Producing manifests and GitOps

23. Kustomize: base and overlays, patches, components.
24. Helm: charts and values, and how apps combine an upstream chart with local values.
25. The GitOps idea: Git holds the desired state, a controller keeps the cluster matching it, drift.
26. Argo CD: Applications, AppProjects, sync, health, sync waves.
27. How this repo is wired: `bootstrap/` → `environments/` → `apps/`, and why `bootstrap/` is applied by hand.
28. Validation and CI: `validate-manifests.sh` and the CI workflow.

Checkpoint: he bumps a chart version or promotes an app to Test from start to finish.

## 5. Extending Kubernetes

29. Controllers: the loop that compares desired state with actual state and fixes the difference.
30. CRDs: how new resource types are added to the cluster.
31. Operators: what they are, and how OpenShift installs them through OLM Subscriptions.
32. Admission and policy: Kyverno, and why tenant namespaces reject some resources.

Checkpoint: he explains what the External Secrets operator does to an ExternalSecret, without reading its source code.

## 6. Platform services

33. cert-manager: Issuers, Certificates, renewal.
34. Secrets: Azure Key Vault, External Secrets and workload identity.
35. The way into the cluster: Akamai → F5 → shared ingress gateway → Pod, with ExternalDNS creating the DNS names.
36. Service mesh: mTLS between services, and Kiali for seeing the traffic.
37. Tenants: what the Tenant resource creates and how `tenants/` is organized.
38. Stateful workloads: the MariaDB operator, OADP backups and restore tests.

Checkpoint: he adds an ExternalSecret or a NetworkPolicy for a tenant and verifies it on the cluster.

## 7. Observability

39. Metrics, logs and traces: what each one is and which question it answers.
40. Grafana: basic PromQL and LogQL.
41. The telemetry pipeline at overview level: collectors → gateway → Mimir, Loki and Tempo, and tenant isolation.
42. Alerts: writing an alert rule and testing it.

Checkpoint: he adds an alert and shows it firing.

## 8. Azure and infrastructure as code

43. Azure basics: subscriptions, resource groups, Entra ID, managed identities, Azure role assignments.
44. Bicep: modules and parameter files, the naming rules in `AGENTS.md`, the deploy workflows.

Checkpoint: he makes a small Bicep change and gets it through review.

## 9. Running the platform

45. Cluster-level changes: bootstrap overlays and what is applied by hand after merge.
46. Security baseline: least privilege, handling secrets, the compliance operator, audit logs.
47. Incidents: shadowing incidents and writing a runbook.
48. Owning a component: upgrading one small app end to end, documenting it and presenting it.

Checkpoint: he delivers an ordinary backlog ticket with review as his only support.
