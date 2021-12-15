data "aws_vpc" "default" {
  default = true
}

resource "aws_lb_target_group" "lb_target_group_marcos" {
  name     = "ALB-target-marcos"
  port     = 80
  vpc_id   = data.aws_vpc.default.id
  protocol = "HTTP"
  health_check {
    enabled = true
    matcher   = "200"
    path     = "/"
    port     = 80
    protocol = "HTTP"
  }
}

resource "aws_lb_target_group_attachment" "my-server1-marcos" {
  target_group_arn = aws_lb_target_group.lb_target_group_marcos.arn
  target_id        = aws_instance.Server1-Marcos.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "my-server2-marcos" {
  target_group_arn = aws_lb_target_group.lb_target_group_marcos.arn
  target_id        = aws_instance.Server2-Marcos.id
  port             = 80
}