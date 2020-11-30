resource "aws_security_group" "load_balancer_sg" {
  name   = join("-", [var.application, var.environment,"alb","sg"])
  vpc_id = var.vpc_id

  ingress = [{
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["100.0.10.0/24"]
    description = null
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  },
  {
    cidr_blocks = ["0.0.0.0/0"]
    description      = ""
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 80
  }]


  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}