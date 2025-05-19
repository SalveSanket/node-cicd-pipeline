#!/usr/bin/env python3

import boto3
import os
import stat

# AWS S3 bucket and key details
BUCKET_NAME = "infra-secure-key-store"
PRIVATE_KEY_S3_KEY = "ssh-sonarqube/ssh-sonarqube"
PUBLIC_KEY_S3_KEY = "ssh-sonarqube/ssh-sonarqube.pub"

# Absolute path to downloaded_keys directory
DEST_DIR = "/Users/sanketsalve/Documents/devops_projects/application-nodejs/sonarqube_server/downloaded_keys"
os.makedirs(DEST_DIR, exist_ok=True)

# Output file paths
private_key_path = os.path.join(DEST_DIR, "ssh-sonarqube")
public_key_path = os.path.join(DEST_DIR, "ssh-sonarqube.pub")

# Initialize S3 client
s3 = boto3.client("s3")

def download_file(key, dest_path):
    try:
        s3.download_file(BUCKET_NAME, key, dest_path)
        print(f"✅ Downloaded: {key} → {dest_path}")
    except Exception as e:
        print(f"❌ Error downloading {key}: {e}")

# Download the keys
download_file(PRIVATE_KEY_S3_KEY, private_key_path)
download_file(PUBLIC_KEY_S3_KEY, public_key_path)

# Set permissions on the private key
try:
    os.chmod(private_key_path, stat.S_IRUSR | stat.S_IWUSR)
    print(f"🔐 Permissions set to 600 for: {private_key_path}")
except Exception as e:
    print(f"❌ Failed to set permissions: {e}")