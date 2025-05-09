# S3 Secure Key Storage with Terraform

This repository demonstrates how to securely store and manage SSH keys using Amazon S3 and Terraform.

## Overview

The goal of this setup is to:

- Create an S3 bucket for storing SSH keys.
- Upload SSH private and public keys to the bucket.
- Use KMS encryption to secure the keys in S3.

## Architecture

- **S3 Bucket**: Stores the SSH keys (`id_rsa` and `id_rsa.pub`).
- **KMS Encryption**: Ensures the keys are stored securely.
- **Terraform**: Automates the infrastructure provisioning and key uploads.

## Features

- S3 bucket created and managed via Terraform.
- KMS encryption for secure storage of SSH keys.
- Uploads SSH private and public keys to the S3 bucket.
- Outputs S3 bucket name, ARN, and key paths for easy reference.

## Prerequisites

- Terraform (v1.0+)
- AWS CLI configured with appropriate credentials and permissions.

## Usage

### 1. Clone the Repository

```bash
git clone https://github.com/SalveSanket/node-cicd-pipeline.git
cd node-cicd-pipeline
```

### 2. Modify `terraform.tfvars`

Set the following variables:

```hcl
aws_region        = "us-east-1"
bucket_name       = "infra-secure-key-store"
private_key_path  = "/path/to/your/private-key"
public_key_path   = "/path/to/your/public-key"
```

Ensure the paths to your private and public SSH keys are correct.

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Apply Terraform Configuration

```bash
terraform apply
```

### 5. Outputs

After apply, you will see:

- **S3 Bucket Name**: The name of the created S3 bucket.
- **S3 Bucket ARN**: The ARN for the S3 bucket.
- **S3 Object Key for Private Key**: Path to the uploaded SSH private key.
- **S3 Object Key for Public Key**: Path to the uploaded SSH public key.

### 6. Accessing Keys

You can access the keys using:

- Private Key: `s3://infra-secure-key-store/ssh-jenkins/ssh-jenkins`
- Public Key: `s3://infra-secure-key-store/ssh-jenkins/ssh-jenkins.pub`

These values are also available as Terraform outputs.

## Security Considerations

- **KMS Encryption**: The keys are encrypted using AES-256 encryption by default.
- **IAM Policies**: Only allow trusted entities (like EC2 or CI/CD roles) to access this bucket.

## Cleanup

To destroy the created resources:

```bash
terraform destroy
```

---
