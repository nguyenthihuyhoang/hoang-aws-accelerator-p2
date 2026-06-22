# Runbook — Gatekeeper Policy Violations

This runbook guides operators and developers on identifying and fixing manifests rejected by OPA Gatekeeper admission controller policies in the cluster.

## Common Violations and Solutions

### 1. Image Tag `:latest` Disallowed
*   **Error Message:** `container <name> has disallowed tag <latest>`
*   **Solution:** Specify a pinned version tag (e.g. `image: ghcr.io/user/repo:1.0.0` or a SHA256 digest) instead of using the mutable `:latest` tag.

### 2. Missing Resource Limits
*   **Error Message:** `container <name> is missing resource limits: [cpu, memory]`
*   **Solution:** Define both CPU and memory limits inside `resources.limits` under the container specification:
    ```yaml
    resources:
      limits:
        cpu: "200m"
        memory: "256Mi"
      requests:
        cpu: "100m"
        memory: "128Mi"
    ```

### 3. Container Running as Root (runAsUser: 0)
*   **Error Message:** `Container <name> has runAsUser set to 0 (root)`
*   **Solution:** Configure a non-root user (e.g., `runAsUser: 1000`) in the container or pod's `securityContext` and ensure the container image is built to run as a non-root user.

### 4. Host Network Enabled
*   **Error Message:** `Pod has hostNetwork set to true`
*   **Solution:** Remove `hostNetwork: true` from the pod spec. Pods should communicate via standard container networking interface (CNI) abstractions and services.

### 5. Registry Whitelist Violation
*   **Error Message:** `container <name> has disallowed registry <docker.io/nginx:...>`
*   **Solution:** Ensure all images are pushed to and pulled from the approved registry (`ghcr.io/nguyenthihuyhoang/*`). External images must be mirrored or proxied through the whitelisted registry.
