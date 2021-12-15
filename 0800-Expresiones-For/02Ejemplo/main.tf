terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.63.0"
    }
  }
}

provider "aws" {
  profile = "Marcos_Palacios"
  region  = "eu-west-1"
}

variable "users" {
  type = set(string)
  default = [ "Marcos","Juan" ]
}

resource "aws_iam_user" "example_user" {
 // count = length(var.users)
  for_each = var.users
  name = each.value
}

output "arn_all_users" {
  value = [for user in aws_iam_user.example_user : user.arn]
}

output "arn_all_users_and_ARN" {
  value = {for user in aws_iam_user.example_user : user.name => user.arn}
}