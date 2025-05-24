# -------------------------------------------------------
# Output: Public IP of the Deployment Server
# -------------------------------------------------------
output "deployment_server_public_ip" {
  description = "The public IP address of the Deployment Server EC2 instance"
  value       = aws_instance.deployment_server.public_ip
}

# -------------------------------------------------------
# Output: SSH Connection Command
# -------------------------------------------------------
output "deployment_server_ssh_command" {
  description = "SSH command to connect to the Deployment Server"
  value       = "ssh -i ${var.private_key_file} ubuntu@${aws_instance.deployment_server.public_ip}"
}

# -------------------------------------------------------
# Output: Key Pair Used
# -------------------------------------------------------
output "deployment_server_key_pair_name" {
  description = "Name of the AWS EC2 key pair used for the Deployment Server"
  value       = aws_key_pair.deployment_server.key_name
}