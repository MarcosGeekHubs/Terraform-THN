resource "aws_instance" "my_server2" {
  ami           = local.ami
  instance_type = var.server_type
  #APROVISIONAMIENTO
  user_data = file("userdata2.sh")
  #Security Group
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  subnet_id              = data.aws_subnet.az_b.id
  tags = {
    Name = "MyServer-2"
  }
}