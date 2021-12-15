terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.63.0"
    }
  }
}

provider "aws" {
  profile = "sandbox"
  region  = "eu-west-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "Marcos-server-SSH" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.Marcos-sg-SSH.id]
  key_name               = "deployer-key-Marcos"
  tags = {
    "Name" = "Marcos-Server-SSH"
  }
}
resource "aws_security_group" "Marcos-sg-SSH" {
  name = "aws_sg_SSH"
  ingress {
    description = "SSH conexion"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "Marcos-key-pair2" {
  key_name   = "deployer-key-Marcos"
  public_key = file("${path.module}/SSH/id_rsa.pub")

}

output "ip-server-ssh" {
  value = aws_instance.Marcos-server-SSH.public_ip
}

//ip-server-ssh = "34.248.93.21"