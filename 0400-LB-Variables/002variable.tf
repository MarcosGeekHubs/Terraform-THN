variable "server_port" {
  description = "Puerto para los servidores"
  type = number  
}

variable "lb_port" {
    description = "Puerto load balnacer"
    type = number
}

variable "server_type" {
  description = "tipo de servidor"
  type = string
}