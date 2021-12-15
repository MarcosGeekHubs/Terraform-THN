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
  profile = "Marcos_Palacios"
  region  = "eu-west-1"
}

variable "users" {
  type = set(string)
}

resource "aws_iam_user" "example_user" {
 // count = length(var.users)
  for_each = var.users
  name = each.value
}