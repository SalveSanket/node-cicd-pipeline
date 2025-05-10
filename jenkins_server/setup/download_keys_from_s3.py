import boto3
import os

# AWS S3 bucket and key details
BUCKET_NAME = "infra-secure-key-store"
PRIVATE_KEY_S3_KEY = "ssh-jenkins/ssh-jenkins"
PUBLIC_KEY_S3_KEY = "ssh-jenkins/ssh-jenkins.pub"

# Output directory
DEST_DIR = os.path.join(os.path.dirname(os.getcwd()), "downloaded_keys")
os.makedirs(DEST_DIR, exist_ok=True)

# File paths
private_key_path = os.path.join(DEST_DIR, "ssh-jenkins")
public_key_path = os.path.join(DEST_DIR, "ssh-jenkins.pub")

# Initialize S3 client
s3 = boto3.client("s3")

def download_file(key, dest_path):
    try:
        s3.download_file(BUCKET_NAME, key, dest_path)
        print(f"✅ Downloaded: {key} → {dest_path}")
    except Exception as e:
        print(f"❌ Error downloading {key}: {e}")

# Download both key files
download_file(PRIVATE_KEY_S3_KEY, private_key_path)
download_file(PUBLIC_KEY_S3_KEY, public_key_path)