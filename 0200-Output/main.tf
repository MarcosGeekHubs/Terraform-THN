# https://thehotelsnetwork.awsapps.com/start
# aws sts get-caller-identity --profile
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

resource "aws_instance" "my_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  #APROVISIONAMIENTO
  user_data = file("userdata.sh")
  #Security Group
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  tags = {
    Name = "MyServer-1"
  }
}

resource "aws_security_group" "web-sg" {
  ingress {
    description = "HTTP accces web"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    //Todas las IP's
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
