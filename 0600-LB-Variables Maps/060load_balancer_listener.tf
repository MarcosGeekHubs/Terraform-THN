resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.alb.arn
  port = var.server_port
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.lb_target_group.arn
    type = "forward"
  }
}