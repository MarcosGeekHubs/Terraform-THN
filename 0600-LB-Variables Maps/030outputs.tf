# Interpolación
output "link_dns_public1" {
  description = "Link DNS server 1"
  value       = "http://${aws_instance.my_server1.public_ip}:${var.server_port}"
}

output "link_dns_public2" {
  description = "Link DNS server 2"
  value       = "http://${aws_instance.my_server2.public_ip}:${var.server_port}"
}

output "Load-Balancer" {
  description = "Link DNS server 2"
  value       = "http://${aws_lb.alb.dns_name}:${var.lb_port}"
}