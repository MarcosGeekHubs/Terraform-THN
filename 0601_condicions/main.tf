terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.63.0"
    }
  }
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
provider "aws" {
  profile = "sandbox"
  region  = "eu-west-1"
}

variable "instance_type" {
  type=string
  description = "tipo de instancia"
 	validation {
    condition     = can(regex("^t2.",var.instance_type))
    error_message = "La instancia no puede ser una diferente a t2."
	}
}

resource "aws_instance" "My_Server" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
}

