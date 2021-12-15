resource "aws_instance" "Server1-Marcos" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  user_data              = file("userdata.sh")
  vpc_security_group_ids = [aws_security_group.web-sg-servar-marcos.id]
  subnet_id              = data.aws_subnet.az_a.id
  tags = {
    "Name" = "Server1-Marcos"
  }



}