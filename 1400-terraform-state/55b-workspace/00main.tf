provider "aws" {
  profile = "sandbox"
  region = var.region_server
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

resource "aws_instance" "my_server" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.server_type
  user_data = file("userdata.sh")
  vpc_security_group_ids = [aws_security_group.wb-sg-workspace.id]
  tags = {
    "Name" = "Marcos-${var.server_profile}"
  }

}

resource "aws_security_group" "wb-sg-workspace" {
  ingress {
      from_port = var.server_port
      to_port = var.server_port
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
       from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}