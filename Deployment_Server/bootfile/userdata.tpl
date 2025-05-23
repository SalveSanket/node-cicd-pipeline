

#!/bin/bash

set -euo pipefail
exec > /var/log/user-data.log 2>&1

echo "===== Updating system packages ====="
apt-get update -y
apt-get upgrade -y

echo "===== Installing dependencies ====="
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common

echo "===== Adding Docker’s official GPG key ====="
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo "===== Setting up Docker repository ====="
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "===== Installing Docker Engine ====="
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "===== Enabling Docker service ====="
systemctl enable docker
systemctl start docker

echo "===== Adding 'ubuntu' user to docker group ====="
usermod -aG docker ubuntu

echo "===== Docker installation complete ====="
docker --version