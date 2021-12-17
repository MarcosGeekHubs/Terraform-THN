terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.63.0"
    }
  }
}

locals {
  region = "eu-west-1"
  ami = var.ubuntu_ami[local.region]
}

provider "aws" {
  profile = "sandbox"
  region  = local.region
}


data "aws_subnet" "az_a" {
  availability_zone = "${local.region}a"
}

data "aws_subnet" "az_b" {
  availability_zone = "${local.region}b"
}