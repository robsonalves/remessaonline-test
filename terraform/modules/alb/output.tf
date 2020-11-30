output "alb_sg_id" {
  value = aws_security_group.load_balancer_sg.id
}

output "target_group_arn" {
  value       = aws_lb_target_group.tgt-http-80.arn
}