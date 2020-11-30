resource "aws_ecs_cluster" "ecs" {
  name = join("-", [var.name, var.environment,"cluster"])
}

data "aws_ami" "ecs" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_security_group" "instance" {
  name        = join("-",[var.name, "container-instance"])
  vpc_id      =  var.vpc_id
}