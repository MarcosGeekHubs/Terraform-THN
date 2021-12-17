#VPc por defecto, si podenmos
data "aws_vpc" "default"{
    #Nos a devolver la VPC por defecto qeu tenemos
    default = true
}
resource "aws_lb_target_group" "lb_target_group" {
  name = "terraform-alb-targer"
  port = var.lb_port
  vpc_id = data.aws_vpc.default.id
  protocol = "HTTP"
  #Tenemos que dfinir los healt checks

  health_check {
    enabled = true
    matcher = "200"
    path = "/"
    port = var.server_port
    protocol = "HTTP"
  }
}

/*
resource "aws_lb_target_group_attachment" "my_server1" {
    target_group_arn = aws_lb_target_group.lb_target_group.arn
    target_id = aws_instance.my_server1.id
    port = 80
}

resource "aws_lb_target_group_attachment" "my_server2" {
    target_group_arn = aws_lb_target_group.lb_target_group.arn
    target_id = aws_instance.my_server2.id
    port = 80
}
*/

resource "aws_lb_target_group_attachment" "my_server" {
  for_each = var.severs_system
    target_group_arn = aws_lb_target_group.lb_target_group.arn
    target_id = aws_instance.my_server[each.key].id
    port = 80
}