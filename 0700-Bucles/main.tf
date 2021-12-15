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

variable "users" {
  type = list(string)
}

resource "aws_iam_user" "example_user" {
  count = length(var.users)
  name = var.users[count.index]
}