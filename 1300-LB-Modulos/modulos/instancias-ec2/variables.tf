variable "puerto_servidor" {
  description = "Puerto para las instancias EC"
  type = number
  default = 8080
}

variable "tipo_instancia" {
  description = "Tipo de instancia EC2"
  type = string
  default = "t2.micro"
}

variable "ami_id" {
  description = "AMI para el servidor"
  type = string
}

variable "servidores" {
  type = map(object({
      nombre = string
      subnet_id = string
  }))
}