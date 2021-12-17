resource "random_pet" "pet" {
  length = 1
}
# ----------------------------------------
# Load Balancer público con dos instancias
# ----------------------------------------
resource "aws_lb" "alb" {
  load_balancer_type = "application"
  name               = "terraformers-alb-${random_pet.pet.id}"
  security_groups    = [aws_security_group.alb.id]
  // Ya tenemos las subnets
  subnets = var.subnet_ids
}

# ------------------------------------
# Security group para el Load Balancer
# ------------------------------------
resource "aws_security_group" "alb" {
  name = "alb-sg-${random_pet.pet.id}"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso al puerto del LB desde el exterior"
    from_port   = var.puerto_lb
    to_port     = var.puerto_lb
    protocol    = "TCP"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso al puerto de nuestros servidores"
    from_port   = var.puerto_servidor
    to_port     = var.puerto_servidor
    protocol    = "TCP"
  }
}

# ----------------------------------------------------
# Data Source para obtener el ID de la VPC por defecto
# ----------------------------------------------------
data "aws_vpc" "default" {
  default = true
}

# ----------------------------------
# Target Group para el Load Balancer
# ----------------------------------
resource "aws_lb_target_group" "this" {
  name     = "terraformers-tg-${random_pet.pet.id}"
  port     = var.puerto_lb
  vpc_id   = data.aws_vpc.default.id
  protocol = "HTTP"

  health_check {
    enabled  = true
    matcher  = "200"
    path     = "/"
    port     = var.puerto_servidor
    protocol = "HTTP"
  }
}

# ------------------------------
# Attachment para los servidores
# ------------------------------
resource "aws_lb_target_group_attachment" "servidor" {
   // Necesitamos conocer antes de la aplicación
  // Count 
  count = length(var.instancia_ids)
//Element acceso a la colección de forma modular
  //Cuando pueda resolver realizará esta acción
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = element(var.instancia_ids, count.index)
  port             = var.puerto_servidor
}

# ------------------------
# Listener para nuestro LB
# ------------------------
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.puerto_lb

  default_action {
    target_group_arn = aws_lb_target_group.this.arn
    type             = "forward"
  }
}
