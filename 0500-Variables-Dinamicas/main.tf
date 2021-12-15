variable "variable_dinamica" {
    //type = bool
    //type = any
    type = list(any)
}

output "valor" {
  value = var.variable_dinamica
}