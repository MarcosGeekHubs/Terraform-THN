resource "aws_instance" "Server2-Marcos" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.server_type
  user_data              = file("userdata2.sh")
  vpc_security_group_ids = [aws_security_group.web-sg-servar-marcos.id]
  subnet_id              = data.aws_subnet.az_b.id
  tags = {
    "Name" = "Server2-Marcos"
  }
}