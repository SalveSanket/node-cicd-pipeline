#!/bin/bash

# -------------------------------------------------------
# System Preparation
# -------------------------------------------------------
echo "🧼 Updating system and installing dependencies..."
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y openjdk-17-jdk wget unzip gnupg2 software-properties-common

# -------------------------------------------------------
# Add SonarQube User
# -------------------------------------------------------
echo "👤 Creating sonar user..."
sudo useradd -m -d /opt/sonarqube -r -s /bin/bash sonar

# -------------------------------------------------------
# Download & Extract SonarQube
# -------------------------------------------------------
echo "📦 Downloading SonarQube Community Edition..."
cd /opt
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.4.1.88267.zip
sudo unzip sonarqube-10.4.1.88267.zip
sudo mv sonarqube-10.4.1.88267 sonarqube
sudo chown -R sonar:sonar /opt/sonarqube

# -------------------------------------------------------
# Configure SonarQube as a Service
# -------------------------------------------------------
echo "⚙️ Configuring SonarQube systemd service..."
sudo bash -c 'cat > /etc/systemd/system/sonarqube.service <<EOF
[Unit]
Description=SonarQube Service
After=network.target

[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
User=sonar
Group=sonar
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF'

# -------------------------------------------------------
# Set Limits for SonarQube
# -------------------------------------------------------
echo "📊 Updating system limits for SonarQube..."
echo "sonar  -  nofile  65536" | sudo tee -a /etc/security/limits.conf
echo "fs.file-max = 65536" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# -------------------------------------------------------
# Enable and Start SonarQube
# -------------------------------------------------------
echo "🚀 Starting SonarQube..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable sonarqube
sudo systemctl start sonarqube

echo "✅ SonarQube installation completed and running!"