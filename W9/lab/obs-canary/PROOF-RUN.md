# W9 Challenge Proof Run

Use this checklist to prove the Challenge to the mentor.

## 1. Alert

- Confirm `lab/obs-canary/monitoring/prometheus-rule.yaml` is synced.
- Confirm the `W9ApiHighErrorRate` alert exists in Prometheus/Alertmanager.

## 2. Email

- Replace the placeholder SMTP settings in `lab/obs-canary/monitoring/alertmanager-config.yaml`.
- Verify Alertmanager can send a test email before doing the failure run.

## 3. Failure injection

- Change `ERROR_RATE` in `lab/obs-canary/k8s-api/api.yaml` from `0` to `0.3` or another non-zero value.
- Commit and push through GitOps.
- Watch the Rollout and confirm the canary aborts.

## 4. Evidence to submit

- Screenshot or log of the Rollout abort.
- Screenshot of the alert firing.
- Screenshot of the email received.
- Short note explaining the metric query and why it maps to the SLO.
