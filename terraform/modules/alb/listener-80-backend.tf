
resource "aws_lb_target_group" "tgt-http-80" {
  name                 = join("-",[var.application,"back",var.environment,"tg"])
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  deregistration_delay = 0
}