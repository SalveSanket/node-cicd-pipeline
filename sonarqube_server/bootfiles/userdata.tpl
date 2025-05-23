#!/bin/bash

# -------------------------------------------------------
# System Preparation
# -------------------------------------------------------
echo "🧼 Updating system and installing dependencies..."
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y openjdk-17-jdk wget unzip gnupg2 software-properties-common net-tools

# -------------------------------------------------------
# Create SonarQube User
# -------------------------------------------------------
echo "👤 Creating sonar user..."
sudo useradd -m -d /opt/sonarqube -r -s /bin/bash sonar || true

# -------------------------------------------------------
# Download & Extract SonarQube
# -------------------------------------------------------
echo "📦 Downloading and extracting SonarQube..."
cd /opt
sudo wget -O sonarqube.zip https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-25.5.0.107428.zip
sudo unzip -o sonarqube.zip -d /opt
sudo rm -f sonarqube.zip
sudo mv /opt/sonarqube-25.5.0.107428 /opt/sonarqube
sudo chown -R sonar:sonar /opt/sonarqube
sudo chmod +x /opt/sonarqube/bin/linux-x86-64/sonar.sh

# -------------------------------------------------------
# Configure System Limits
# -------------------------------------------------------
echo "📊 Configuring system limits..."
echo "sonar  -  nofile  65536" | sudo tee -a /etc/security/limits.conf
echo "fs.file-max = 65536" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# -------------------------------------------------------
# Create systemd service for SonarQube
# -------------------------------------------------------
echo "⚙️ Creating SonarQube systemd service..."

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
WorkingDirectory=/opt/sonarqube
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF'

# -------------------------------------------------------
# Enable and Start SonarQube Service
# -------------------------------------------------------
echo "🚀 Starting SonarQube via systemd..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable sonarqube
sudo systemctl start sonarqube

echo "✅ SonarQube Community Edition installed and running on port 9000!"