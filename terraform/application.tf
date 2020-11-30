resource "aws_ecs_task_definition" "app" {
  family = "remessaonline-test-svc"

  container_definitions = <<EOF
[
  {
    "name": "nginx",
    "image": "$DOCKER_IMAGE",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "remessaonline-test-svc-nginx",
        "awslogs-region": "us-east-1"
      }
    },
    "memory": 128,
    "cpu": 100
  }
]
EOF
}

module "nginx-app" {
  source = "./modules/ecs-service"

  name                 = "nginx-test-app"
  alb_tg_arn           = module.alb.target_group_arn
  cluster              = module.ecs.cluster_id
  container_name       = "nginx"
  container_port       = "80"
  log_groups           = ["remessaonline-test-svc-nginx"]
  task_definition_arn  = aws_ecs_task_definition.app.arn

  tags = {
    Owner       = var.application
    Environment = var.environment
  }
}