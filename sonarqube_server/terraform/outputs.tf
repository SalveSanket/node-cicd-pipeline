# -------------------------------------------------------
# Output: Public IP of the EC2 Instance
# -------------------------------------------------------
output "sonarqube_instance_public_ip" {
  description = "The public IP address of the SonarQube EC2 instance"
  value       = aws_instance.sonarqube.public_ip
}

# -------------------------------------------------------
# Output: SonarQube Web URL
# -------------------------------------------------------
output "sonarqube_web_url" {
  description = "Access SonarQube Web UI in browser"
  value       = "http://${aws_instance.sonarqube.public_ip}:9000"
}

# -------------------------------------------------------
# Output: SSH Connection Command
# -------------------------------------------------------
output "ssh_access_command" {
  description = "SSH command to connect to the SonarQube server"
  value       = "ssh -i ${var.private_key_file} ubuntu@${aws_instance.sonarqube.public_ip}"
}

# -------------------------------------------------------
# Output: Key Pair Used
# -------------------------------------------------------
output "key_pair_name" {
  description = "Name of the AWS EC2 key pair used"
  value       = aws_key_pair.sonarqube.key_name
}