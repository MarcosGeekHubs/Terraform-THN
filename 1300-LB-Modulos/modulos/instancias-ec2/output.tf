output "instancia_ids" {
  value = [for servidores in aws_instance.servidor : servidor.id]
}