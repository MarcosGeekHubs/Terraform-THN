resource "aws_lb" "alb"{
    load_balancer_type = "application"
    name = "terraform-alb"
    security_groups = [aws_security_group.alb_sg.id]
    #Subnet donde vamos a 
    subnets = [data.aws_subnet.az_a.id, data.aws_subnet.az_b.id]

}

resource "aws_security_group" "alb_sg" {
    name = "alb-sg"
    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        description = "Acceso al puesto 80 desde el exterior"
        from_port = var.lb_port
        to_port = var.lb_port
        protocol = "TCP"
    }
    egress{
        cidr_blocks = ["0.0.0.0/0"]
        description = "Acceso al puesto 80 desde nuestro servidor"
        from_port = var.lb_port
        to_port = var.lb_port
        protocol = "TCP"
    }
  
}