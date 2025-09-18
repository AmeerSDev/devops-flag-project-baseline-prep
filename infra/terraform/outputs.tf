output "Public-VM-IP" {
    value = aws_instance.North_Virginia-Public1-VM.public_ip
}

output "Private1-VM-IP" {
    value = aws_instance.North_Virginia-Private1-VM.private_ip
}

output "Private2-VM-IP" {
    value = aws_instance.North_Virginia-Private2-VM.private_ip
}

output "ALB-DNS-Name" {
    value = aws_lb.North_Virginia-ALB.dns_name
}

# Output for Key Pair (Deprecated)
# output "Key-Pair" {
#   value = file("${path.module}/KP.pem")
#   sensitive = true
# }