variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "private_key_path" {
  description = "Local file path to the SSH private key"
  type        = string
  default     = "/Users/sanketsalve/Documents/devops_projects/application-nodejs/S3/terraform/keys/ssh-jenkins"
}

variable "public_key_path" {
  description = "Local file path to the SSH public key"
  type        = string
  default     = "/Users/sanketsalve/Documents/devops_projects/application-nodejs/S3/terraform/keys/ssh-jenkins.pub"
}