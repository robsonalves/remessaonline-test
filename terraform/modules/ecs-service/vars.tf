variable "alb_tg_arn" {
  description = "ARN of the ALB target group"
}

variable "cluster" {
  description = "ECS Cluster"
}

variable "container_name" {
  description = "Container Name"
}

variable "container_port" {
  description = "Running Port"
  default     = 80
}

variable "deployment_maximum_percent" {
  description = "desired tasks during a deployment"
  default     = 200
}

variable "deployment_minimum_healthy_percent" {
  description = "desired tasks during a deployment"
  default     = 100
}

variable "desired_count" {
  description = "Desired count of the ECS task"
  default     = 1
}

variable "log_groups" {
  description = "Log groups that will be created in CloudWatch Logs"
  default     = []
}

variable "name" {
  description = "Name of the ecs service"
  default     = "remessaonline-test"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "task_definition_arn" {
  description = "ARN of the task defintion for the ECS service"
}
