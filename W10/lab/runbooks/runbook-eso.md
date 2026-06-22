# Runbook — External Secrets Operator (ESO) Syncing

This runbook guides operators on verifying, troubleshooting, and resolving issues related to AWS Secrets Manager synchronization using External Secrets Operator.

## Verifying Synchronization

To check if the secrets are successfully synced from AWS Secrets Manager to Kubernetes:
```bash
# 1. Check the ExternalSecret status
kubectl get externalsecret -n demo

# 2. Check the SecretStore status
kubectl get secretstore -n demo

# 3. Retrieve the generated local secret value
kubectl get secret db-secret -n demo -o jsonpath='{.data.password}' | base64 -d
```

## Common Failure Modes

### 1. Status: `Connection Failed` or `Access Denied`
*   **Cause:** The SecretStore is unable to authenticate with AWS using the referenced credentials.
*   **Solution:**
    *   Verify if the `aws-creds` secret exists in namespace `demo` containing valid `access-key` and `secret-key`.
    *   Verify the AWS IAM user or Role has permission `secretsmanager:GetSecretValue` on the target secret path `demo/db/password`.

### 2. Secret Not Updating
*   **Cause:** The `refreshInterval` is misconfigured or the operator pod is crashing.
*   **Solution:**
    *   Ensure the `refreshInterval` in `ExternalSecret` spec is set to a short duration (e.g. `10s`) for low rotation latency.
    *   Check the logs of the `external-secrets` operator controller:
        ```bash
        kubectl logs -n external-secrets -l app.kubernetes.io/instance=external-secrets
        ```
