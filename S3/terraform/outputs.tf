output "s3_bucket_name" {
  value       = aws_s3_bucket.ssh_key_bucket.id
  description = "Name of the created S3 bucket"
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.ssh_key_bucket.arn
  description = "ARN of the created S3 bucket"
}

output "s3_bucket_region" {
  value       = aws_s3_bucket.ssh_key_bucket.region
  description = "Region of the created S3 bucket"
}

output "private_key_object_key" {
  value       = aws_s3_object.private_key.key
  description = "S3 object key (path) to the private SSH key"
}

output "public_key_object_key" {
  value       = aws_s3_object.public_key.key
  description = "S3 object key (path) to the public SSH key"
}

output "public_key_sonarqube_object_key" {
  value       = aws_s3_object.public_key_sonarqube.key
  description = "ETag (MD5 hash) of the public SSH key object"
}

output "private_key_sonarqube_object_key" {
  value       = aws_s3_object.private_key_sonarqube.key
  description = "S3 object key (path) to the private SSH key for SonarQube"
}

