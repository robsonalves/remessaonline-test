
data "template_file" "user_data" {
  template = file(join("/",[path.module, "template", "user-data.sh"]))
  vars = {
    cluster_name = aws_ecs_cluster.ecs.name
  }
}

resource "aws_launch_configuration" "instance" {
  name_prefix          = join("-",[var.name, "ls"])
  image_id             = data.aws_ami.ecs.id
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.instance.name
  user_data            = data.template_file.user_data.rendered
  security_groups      = [aws_security_group.instance.id]

  root_block_device {
    volume_size = var.instance_root_volume_size
    volume_type = "gp2"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name = join("-",[var.name, "asg"])

  launch_configuration = aws_launch_configuration.instance.name
  vpc_zone_identifier  = ["var.vpc_subnets"]
  max_size             = var.asg_max_size
  min_size             = var.asg_min_size
  desired_capacity     = var.asg_desired_size

  health_check_grace_period = 300
  health_check_type         = "EC2"

  lifecycle {
    create_before_destroy = true
  }
}
