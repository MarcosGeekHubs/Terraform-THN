# Solamente de ejemplo! No ejecutar!
provider "aws" {
  profile = "sandbox"
  region = "eu-west-1"
}

module "ec2_cluster" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = "servidor-1"
  instance_count = 1

  ami                    = "ami-0aef57767f5404a3c"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-04e019950b16a97b4"]
  subnet_id              = "subnet-06d7cceef1f381aa7"

}
