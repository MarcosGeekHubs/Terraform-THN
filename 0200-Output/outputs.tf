# Nos va a mostrar la DNS publica
output "dns_public" {
description = "Public DNS server"
  value = aws_instance.my_server.public_ip
}

# Interpolación
output "link_dns_public" {
description = "Link DNS server"
  value = "http://${aws_instance.my_server.public_dns}"
}