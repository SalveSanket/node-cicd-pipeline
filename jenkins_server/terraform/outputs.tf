locals {
  # Default EC2 username for Ubuntu AMI
  ec2_default_user = "ubuntu"
}

# Output the public IP of the Jenkins server
output "jenkins_instance_public_ip" {
  description = "Public IP address of the Jenkins EC2 instance"
  value       = aws_instance.jenkins_instance.public_ip
}

# Output the SSH connection command
output "ssh_connection_string" {
  description = "SSH command to access the Jenkins server"
  value       = "ssh -i ${var.private_key_file} ubuntu@${aws_instance.jenkins_instance.public_ip}"
}

# Output the Jenkins Web UI URL
output "jenkins_url" {
  description = "Jenkins Web UI URL"
  value       = "http://${aws_instance.jenkins_instance.public_ip}:8080"
}

# Output the path to the SSH private key
output "private_key_file" {
  description = "Path to the private key used for SSH"
  value       = var.private_key_file
}