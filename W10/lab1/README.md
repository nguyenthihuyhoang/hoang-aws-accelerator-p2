# W10 Lab 1 - RBAC + Gatekeeper

Thư mục `lab1` chứa các manifest hoàn thiện theo đề bài Lab 1 từ slide buổi sáng.

## Nội dung

- `rbac/roles.yaml`: 3 Role/ClusterRole cho `alice`, `bob`, `carol`
- `rbac/rolebindings.yaml`: 3 binding gán user vào role/clusterrole
- `argocd/apps/rbac.yaml`: ArgoCD Application sync `rbac/`
- `gatekeeper/constraints/`: 4 constraint Gatekeeper yêu cầu + 1 custom policy
- `argocd/apps/gatekeeper.yaml`: ArgoCD Application sync `gatekeeper/`

## Hướng dẫn

1. Thay `repoURL` trong `argocd/apps/*.yaml` thành repo fork của bạn.
2. Đảm bảo ArgoCD root repo đã trỏ vào repo của bạn.
3. Sync 2 app trong ArgoCD: `lab1-rbac` và `lab1-gatekeeper`.

### Tự kiểm tra

RBAC:

```bash
kubectl auth can-i create deploy -n demo --as alice
kubectl auth can-i create deploy -n kube-system --as alice
kubectl auth can-i get pods -A --as bob
kubectl auth can-i delete nodes --as carol
```

Gatekeeper:

- Kiểm tra constraint reject manifest vi phạm. Ví dụ: Pod dùng image `:latest`, thiếu `resources.limits`, `runAsUser: 0` hoặc `hostNetwork: true`.
- Kiểm tra constraint pass với workload hợp lệ (image pinned + limits + non-root + owner label).

## Evidence cho Lab 1

1. Chụp màn hình hoặc copy kết quả của 4 lệnh `kubectl auth can-i ... --as`:
   - `yes` cho `alice` tạo deploy trong namespace `demo`
   - `no` cho `alice` tạo deploy trong namespace `kube-system`
   - `yes` cho `bob` xem pods toàn cụm
   - `no` cho `carol` xóa nodes
2. Chụp màn hình hoặc copy kết quả thử deploy các manifest Gatekeeper:
   - manifest dùng image `:latest` bị reject
   - manifest thiếu `resources.limits` bị reject
   - manifest có `runAsUser: 0` bị reject
   - manifest có `hostNetwork: true` bị reject
   - manifest hợp lệ được pass
3. Ghi rõ file đã sửa trong repo fork: `rbac/roles.yaml`, `rbac/rolebindings.yaml`, `gatekeeper/constrainttemplates/*`, `gatekeeper/constraints/*`, `argocd/apps/*.yaml`.
4. Nếu dùng ArgoCD, chụp màn hình trạng thái `Synced/Healthy` của app `lab1-rbac` và `lab1-gatekeeper`.

> Evidence có thể là ảnh chụp màn hình, output terminal copy/paste, hoặc file log ngắn gọn.

## Ghi chú

- `alice` được phép CRUD workload chỉ trong namespace `demo`.
- `bob` được phép thao tác pod toàn cụm.
- `carol` chỉ được phép đọc toàn cụm.
- Custom policy bắt buộc workload có label `owner`.
