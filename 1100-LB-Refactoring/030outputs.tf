# Interpolación
output "link_dns_public1" {
  description = "Link DNS server "
  value       = [for server in aws_instance.my_server :
   "http://${server.public_ip}:${var.server_port}"]
}



output "Load-Balancer" {
  description = "Link DNS server 2"
  value       = "http://${aws_lb.alb.dns_name}:${var.lb_port}"
}