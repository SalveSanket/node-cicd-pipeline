# -------------------------------------------------------
# Output: Public IP of the EC2 Instance
# -------------------------------------------------------
output "deployment_server_public_ip" {
  description = "The public IP address of the Deployment Server EC2 instance"
  value       = aws_instance.DeploymentServer.public_ip
}

# -------------------------------------------------------
# Output: SSH Access Command
# -------------------------------------------------------
output "deployment_server_ssh_command" {
  description = "SSH command to connect to the Deployment Server instance"
  value       = "ssh -i ${var.private_key_file} ubuntu@${aws_instance.DeploymentServer.public_ip}"
}

# -------------------------------------------------------
# Output: EC2 Key Pair Name
# -------------------------------------------------------
output "deployment_server_key_pair_name" {
  description = "The name of the AWS EC2 key pair used for Deployment Server"
  value       = aws_key_pair.DeploymentServer.key_name
}