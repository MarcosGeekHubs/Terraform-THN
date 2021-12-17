resource "aws_instance" "webserver-Marcos" {
  ami           = lookup(var.aws_amis, var.region)
  instance_type = var.instance_type
  count         = 2
  tags = {
    Name = "webserver-Marcos"
  }
}