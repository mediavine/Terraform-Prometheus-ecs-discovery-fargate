resource "aws_ecs_service" "prometheus-service" {
  name = "${var.environment}-${var.name_prefix}-prometheus-service"
  cluster = var.cluster_name
  task_definition = aws_ecs_task_definition.prometheus-fargate.arn
  desired_count = var.prom_desired_count
  launch_type = "FARGATE"
  platform_version = var.platform_version
  deployment_minimum_healthy_percent = "100"

  network_configuration {
    security_groups = var.security_groups
    subnets = var.subnets
    assign_public_ip = var.assign_public_ip
  }

  lifecycle {
    create_before_destroy = false
  }
}