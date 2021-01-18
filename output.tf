output "instance_id" {
  description = " id of created instances. "
  value = aws_instance.instance.id
}

output "private_ip" {
  description = "Private IPs of created instances. "
  value = aws_instance.instance.private_ip
}

output "public_ip" {
  description = "Public IPs of created instances. "
  value = aws_instance.instance.public_ip
}


output "instance_id1" {
  description = " id of created instances. "
  value = aws_instance.instance1.id
}

output "private_ip1" {
  description = "Private IPs of created instances. "
  value = aws_instance.instance1.private_ip
}

output "public_ip1" {
  description = "Public IPs of created instances. "
  value = aws_instance.instance1.public_ip
}