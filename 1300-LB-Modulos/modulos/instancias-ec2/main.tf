resource "aws_instance" "servidor" {
  for_each = var.servidores
  ami = var.ami_id
  instance_type = var.tipo_instancia
  vpc_security_group_ids = [aws_security_group.mi_grupo_de_seguridad.id]
  subnet_id = each.value.subnet_id
  user_data = <<-EOF
              #!/bin/bash
              echo "Hola Terraformers! Soy ${each.value.nombre}" > index.html
              nohup busybox httpd -f -p ${var.puerto_servidor} &
              EOF
    tags = {
        Name = each.value.nombre
    }
}

resource "aws_security_group" "mi_grupo_de_seguridad" {
  name = "servidor-sg"
  ingress{
      from_port = var.puerto_servidor
      to_port = var.puerto_servidor
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
  }
}