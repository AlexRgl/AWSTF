output "Server_id" {
  description = " id of created instances. "
  value = aws_instance.instance.id
}

output "private_ip_Server" {
  description = "Private IPs of created instances. "
  value = aws_instance.instance.private_ip
}

output "public_ip_server" {
  description = "Public IPs of created instances. "
  value = aws_instance.instance.public_ip
}


output "Client_id" {
  description = " id of created instances. "
  value = aws_instance.instance1.id
}

output "Private_ip_Client" {
  description = "Private IPs of created instances. "
  value = aws_instance.instance1.private_ip
}

output "Public_ip_Client" {
  description = "Public IPs of created instances. "
  value = aws_instance.instance1.public_ip
}