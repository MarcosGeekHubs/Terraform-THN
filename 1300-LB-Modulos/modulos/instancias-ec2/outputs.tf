output "instancia_ids" {
  description = "IDs de las instancias"
    //Lista
  value       = [for servidor in aws_instance.servidor : servidor.id]
}
