resource "aws_lb" "alb-marcos2" {
  load_balancer_type = "application"
  name               = "alb-marcos2"
  security_groups    = [aws_security_group.alb-sg-marcos.id]
  subnets            = [data.aws_subnet.az_a.id, data.aws_subnet.az_b.id]

}

resource "aws_security_group" "alb-sg-marcos" {
  ingress {
    description = "HTTP"
    from_port   = var.lb_port
    to_port     = var.lb_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

}