output "iam_instance_profile_id" {
  value = aws_iam_instance_profile.instance.id
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs.id
}

output "cluster_id" {
  value =   aws_ecs_cluster.ecs.id
}

output "cloudwatch_log_group" {
  value = join("-", [var.name, var.environment, "cluster"])
}