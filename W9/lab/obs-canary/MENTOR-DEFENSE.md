# W9 Afternoon Labs: Explain First, Then Finish Challenge

This note is the working guide for the afternoon part of W9.

## The workflow

1. Understand the role of each file before changing anything.
2. Finish the Challenge on top of the existing GitOps base.
3. Re-explain the whole repo from the final state so mentor questions are answerable from the code itself.

## What the repo already gives us

### Morning foundation

- `lab/gitops/k8s/web.yaml` gives the simple GitOps-managed app.
- `lab/gitops/k8s/namespace.yaml` sets the target namespace in Git.
- `lab/gitops/argocd/apps/web.yaml` is the first ArgoCD Application.
- `lab/gitops/argocd/root.yaml` is the app-of-apps root.
- `lab/gitops/argocd/apps/kube-prometheus-stack.yaml` and `lab/gitops/argocd/apps/argo-rollouts.yaml` extend the same GitOps pattern to the afternoon stack.

### Afternoon scaffold

- `lab/obs-canary/app/app.py` is the small API to expose `/`, `/healthz`, and `/metrics`.
- `lab/obs-canary/app/Dockerfile` and `requirements.txt` make the API buildable.
- `lab/obs-canary/k8s-api/api.yaml` defines the Rollout and Service.
- `lab/obs-canary/k8s-api/servicemonitor.yaml` makes Prometheus scrape the app.
- `lab/obs-canary/k8s-api/analysis-template.yaml` defines the Prometheus-based success check for canary.
- `lab/gitops/argocd/apps/api.yaml` wires the app into the GitOps root.

## How to explain the Challenge

The Challenge is not a new architecture. It is the combination of three layers already present in the course:

- GitOps: source of truth, sync, revert, root/app-of-apps.
- Observability: Prometheus, metrics, SLO, burn rate, and alerting.
- Canary: Rollout, stepwise traffic shifting, and automatic abort when metrics are bad.

## What is still missing for a full Challenge submission

The scaffold already covers the app, Rollout, ServiceMonitor, and AnalysisTemplate. The remaining work is the last mile:

- A real alert rule for the target SLO or burn rate.
- An email receiver or equivalent notification path for the alert.
- A proof run that injects failure and shows the canary aborting.
- A short README section with the metric/query rationale.

## Suggested finish order

1. Keep the GitOps root as-is and let ArgoCD manage the afternoon apps.
2. Add the alerting layer for SLO or burn-rate violations.
3. Hook the alert to email.
4. Validate with failure injection.
5. Capture the final explanation in this file so it can be used for mentor Q&A.

## Defense cheat sheet

- Why `Rollout` instead of `Deployment`? Because the challenge needs progressive delivery, pause, and abort.
- Why `ServiceMonitor`? Because Prometheus must scrape `/metrics` from the app.
- Why `AnalysisTemplate`? Because it turns metrics into a canary decision.
- Why GitOps for the afternoon stack? Because the course expects everything to stay reproducible from Git.
- Why no frontend? Because the challenge is about traffic, metrics, and delivery safety, not UI.

## If asked about the current repo state

Say this clearly:

- Morning GitOps is done enough to serve as the base.
- Afternoon scaffold exists for app, rollout, and observability.
- The only remaining true challenge item is the final alerting + proof phase.
