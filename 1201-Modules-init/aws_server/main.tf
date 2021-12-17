variable "instance_type" {
  type =string
  description = "Tamaño server"
}

resource "aws_instance" "server-module-marcos" {
  ami = "ami-08edbb0e85d6a0a07"
  instance_type = var.instance_type
}

output "public_ip" {
  value = aws_instance.server-module-marcos.public_dns
}