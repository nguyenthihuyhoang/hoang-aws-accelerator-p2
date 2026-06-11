# W9 Observability + Canary

This folder contains the afternoon lab scaffold.

## Files

- `app/` - small Flask API with `/`, `/healthz`, and `/metrics`
- `k8s-api/` - Rollout, Service, ServiceMonitor, and AnalysisTemplate

## GitOps integration

The existing GitOps root at `lab/gitops/argocd/root.yaml` already watches `lab/gitops/argocd/apps/`, so the new Applications in that folder will be picked up by ArgoCD once synced.

## Mentor defense

See [MENTOR-DEFENSE.md](MENTOR-DEFENSE.md) for the explain-first workflow, file map, challenge gaps, and the order to finish the final challenge.
