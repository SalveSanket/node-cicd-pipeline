# S3 SSH Key Downloader Script

This Python script downloads SSH key files (private and public) from a specified S3 bucket and stores them in a `downloaded_keys` directory one level above the script's location.

## Requirements

- Python 3
- `boto3` installed (`pip install boto3`)
- AWS CLI configured (`aws configure`) with sufficient permissions to access the S3 bucket

## File Details

**Script:** `download_keys_from_s3.py`

**S3 Bucket Name:** `infra-secure-key-store`  
**Public Key Object Key:** `ssh-jenkins/ssh-jenkins.pub`  
**Private Key Object Key:** `ssh-jenkins/ssh-jenkins`

**Destination Directory:** `../downloaded_keys/`

## Script Behavior

1. Initializes a connection to AWS S3 using `boto3`.
2. Creates a `downloaded_keys` folder in the parent directory if it doesn't exist.
3. Downloads the specified SSH key files from S3 into that folder.

## Usage

Run the script using:

```bash
python3 download_keys_from_s3.py