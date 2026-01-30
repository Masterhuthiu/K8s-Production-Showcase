#!/bin/bash
# Lệnh khởi tạo cực nhanh
k3d cluster create --config cluster-config.yaml

# Đợi node sẵn sàng
kubectl wait --for=condition=Ready nodes --all --timeout=60s

# Cài đặt Nginx Ingress Controller (Chuẩn Production)
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml