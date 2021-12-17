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

module "aws_server" {
    source = "./aws_server"
    instance_type = "t2.micro"  
}

output "public_ip" {
  value = module.aws_server.public_ip
}