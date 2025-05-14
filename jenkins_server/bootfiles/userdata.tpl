#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Log output to /var/log/user-data.log
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "Updating system packages..."
sudo apt-get update -y
sudo apt-get upgrade -y

echo "Installing required dependencies..."
sudo apt-get install -y ca-certificates curl gnupg

echo "Installing Node.js (v18) and npm..."
sudo apt-get install -y build-essential
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "Verifying Node.js and npm installation..."
node -v
npm -v

# Add Jenkins key and repository
echo "Adding Jenkins GPG key and repository..."
sudo mkdir -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "Updating package list after adding Jenkins repo..."
sudo apt-get update -y

# Install Java (required for Jenkins)
echo "Installing Java (OpenJDK 17)..."
sudo apt-get install -y openjdk-17-jdk

# Install Jenkins
echo "Installing Jenkins..."
sudo apt-get install -y jenkins

# Enable and start Jenkins service
echo "Enabling and starting Jenkins service..."
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Check Jenkins status
echo "Checking Jenkins service status..."
sudo systemctl status jenkins || true  # Don't fail the script if status returns non-zero

echo "Jenkins installation and setup completed successfully."