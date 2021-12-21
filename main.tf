provider "aws" {
  profile = "sandbox"
  region = "eu-west-1"
}

resource "aws_instance" "Marcos-import" {
  ami = "ami-04dd4500af104442f"
  instance_type = "t2.micro"
}