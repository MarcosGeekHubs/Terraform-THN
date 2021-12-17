variable "puerto_servidor" {
  description = "Puerto para las instancias EC2"
  type        = number
  default     = 8080

  validation {
    condition     = var.puerto_servidor > 0 && var.puerto_servidor <= 65536
    error_message = "El valor del puerto debe estar comprendido entre 1 y 65536."
  }
}

variable "tipo_instancia" {
  description = "Tipo de la instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  // Queremos un módulo reutilizable,
  description = "AMI para los servidores"
  type        = string
}

variable "servidores" {
    /*
  Le pasamos directamente el subnet donde queremos desplegar el servidor
  - Estavamos desplegando en una subnet, definiamos el avalivily_zone
  - Esta lógica es más de la acción que llama al módulo y lo tiene que pasar resuelto
  - Evitar codigo Hardcodeado
  */
  description = "Mapa de servidores con su correspondiente subnet publica"

  type = map(object({
    nombre    = string,
    subnet_id = string
    })
  )
}

