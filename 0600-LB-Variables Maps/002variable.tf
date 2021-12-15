variable "ubuntu_ami" {
  type = map(string)
  description = "AMI region"
  default = {
    //Copiamos los valores del AWS en cada reguión son diferentes
    "eu-west-1" = "ami-08ca3fed11864d6bb"
    "eu-west-2" = "ami-0015a39e4b7c0966f"
  }
}

variable "server_port" {
  description = "Puerto para los servidores"
  type        = number
  default = 80
  validation {
    condition = var.server_port > 0 && var.server_port <= 65536
    error_message= "Puerto incorrecto en server_port el puerto tiene que estar comprendido entre 1 y 65536."
  }

}

variable "lb_port" {
  description = "Puerto para el balanceador de carga"
  type        = number
  default = 80
}

variable "server_type" {
  description = "tipo de servidores"
  type        = string
  default = "t2.micro"

}
