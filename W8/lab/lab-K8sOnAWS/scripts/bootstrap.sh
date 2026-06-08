#!/bin/bash
# Ghi nhận log cài đặt để debug
exec > >(tee -i /var/log/user-data.log) 2>&1
set -x

export DEBIAN_FRONTEND=noninteractive

# 1. Cài đặt Docker và các dependencies cần thiết
apt-get update -y
apt-get install -y docker.io conntrack curl
systemctl enable docker
systemctl start docker

# 2. Cài đặt Minikube & Kubectl
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install kubectl /usr/local/bin/kubectl

# 3. Khởi tạo cụm Minikube (Map port 30000 ra EC2 host & dùng --force cho root user)
export MINIKUBE_HOME=/root
export KUBECONFIG=$MINIKUBE_HOME/.kube/config
minikube start --driver=docker --force --ports=30000:30000

# 4. Ghi manifest K8s ra file (được inject động từ Terraform)
cat <<'EOF' > /tmp/app.yaml
${app_yaml_content}
EOF

# 5. Deploy App
kubectl apply -f /tmp/app.yaml
