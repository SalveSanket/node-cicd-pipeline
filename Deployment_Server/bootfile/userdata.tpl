#!/bin/bash

set -euo pipefail
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "=== [1/7] Updating system packages ==="
apt-get update -y
apt-get upgrade -y

echo "=== [2/7] Installing required dependencies ==="
apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  software-properties-common \
  apt-transport-https

echo "=== [3/7] Adding Docker’s official GPG key ==="
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo "=== [4/7] Setting up Docker repository ==="
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "=== [5/7] Installing Docker Engine & Plugins ==="
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "=== [6/7] Enabling Docker service & adding user ==="
systemctl enable docker
systemctl start docker
usermod -aG docker ubuntu

echo "=== [7/7] Docker installation verification ==="
docker --version && echo "✅ Docker installed successfully" || echo "❌ Docker installation failed"