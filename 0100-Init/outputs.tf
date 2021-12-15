output "dns_public" {
    description = "Public DNS"
    value = "http://${aws_instance.my_server.public_dns}"
}

output "ip_public" {
    description = "Public UPs"
    value = "http://${aws_instance.my_server.public_ip}"
}