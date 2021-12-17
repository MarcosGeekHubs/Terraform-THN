variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "region" {
  type    = string
  default = "eu-west-1"

}
variable "aws_amis" {
  type = map(any)
  default = {
    "eu-west-1"    = "ami-08ca3fed11864d6bb"
    "us-east-1"    = "ami-04505e74c0741db8d"
    "eu-central-1" = "ami-0d527b8c289b4af7f"
  }
}