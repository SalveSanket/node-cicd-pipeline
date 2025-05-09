resource "aws_s3_bucket" "ssh_key_bucket" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = {
    Name = "Jenkins SSH Key Bucket"
  }
}

resource "aws_s3_object" "private_key" {
  bucket                 = aws_s3_bucket.ssh_key_bucket.id
  key                    = "ssh-jenkins/ssh-jenkins"
  source                 = var.private_key_path
  etag                   = filemd5(var.private_key_path)
  server_side_encryption = "AES256"
}

resource "aws_s3_object" "public_key" {
  bucket                 = aws_s3_bucket.ssh_key_bucket.id
  key                    = "ssh-jenkins/ssh-jenkins.pub"
  source                 = var.public_key_path
  etag                   = filemd5(var.public_key_path)
  server_side_encryption = "AES256"
}