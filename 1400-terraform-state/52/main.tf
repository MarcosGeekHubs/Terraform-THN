provider "aws" {
  profile = "sandbox"
  region = "eu-west-1"
}

resource "aws_instance" "servidor-marcos" {
  ami           = "ami-04dd4500af104442f"
  instance_type = "t2.micro"
}
// terraform import aws_instance.servidor i-00fb80115955c14f5
// terraform state mv aws_instance.servidor aws_instance.servidor-marcos