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

data "aws_subnet" "az_a" {
  availability_zone = "eu-west-1a"
}

data "aws_subnet" "az_b" {
  availability_zone = "eu-west-1b"
}