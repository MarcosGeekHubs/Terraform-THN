resource "aws_instance" "my_server1" {
  ami           = local.ami
  instance_type = var.server_type
  #APROVISIONAMIENTO
  user_data = file("userdata.sh")
  #Security Group
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  subnet_id              = data.aws_subnet.az_a.id
  tags = {
    Name = "MyServer-1"
  }
}