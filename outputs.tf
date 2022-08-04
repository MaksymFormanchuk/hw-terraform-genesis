output "web_server_public_ip" {
  value = aws_instance.IaC_workshop.public_ip
}