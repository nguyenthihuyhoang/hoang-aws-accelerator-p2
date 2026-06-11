# W9 Observability + Canary

This folder contains the afternoon lab scaffold.

## Files

- `app/` - small Flask API with `/`, `/healthz`, and `/metrics`
- `k8s-api/` - Rollout, Service, ServiceMonitor, and AnalysisTemplate

## GitOps integration

The existing GitOps root at `lab/gitops/argocd/root.yaml` already watches `lab/gitops/argocd/apps/`, so the new Applications in that folder will be picked up by ArgoCD once synced.

## Challenge status

The afternoon scaffold now includes the canary app, ServiceMonitor, AnalysisTemplate, and a monitoring folder for alerting and email routing. The remaining live work is to replace the placeholder SMTP settings, inject failure, and capture the proof run.

See [PROOF-RUN.md](PROOF-RUN.md) for the exact alert -> email -> failure injection -> evidence sequence.

## Mentor defense

See [MENTOR-DEFENSE.md](MENTOR-DEFENSE.md) for the explain-first workflow, file map, challenge gaps, and the order to finish the final challenge.
