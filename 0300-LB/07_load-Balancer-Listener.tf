resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.alb-marcos2.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.lb_target_group_marcos.arn
    type             = "forward"
  }
}