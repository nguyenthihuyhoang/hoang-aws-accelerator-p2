# Monitoring layer for W9

This folder holds the alerting layer used to finish the Challenge.

## What it does

- `prometheus-rule.yaml` raises an alert when API 5xx rate crosses the SLO threshold.
- `alertmanager-config.yaml` routes critical alerts to email.

## Important note

The email receiver uses placeholder SMTP values. Replace them with the real mentor or personal SMTP settings before trying a live email delivery test.
