resource "aws_alb" "alb" {
  name            = join("-", [var.application,var.environment, "alb"])
  subnets         = var.public_subnet
  security_groups = [aws_security_group.load_balancer_sg.id]
  internal        = var.internal
}