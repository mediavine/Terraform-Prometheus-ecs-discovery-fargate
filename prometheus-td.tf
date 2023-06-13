resource "aws_ecs_task_definition" "prometheus-fargate" {
  family                = "prometheus-ecs-fargate-discovery"
  execution_role_arn = var.prom_execution_role_arn == '' ? aws_iam_role.prometheus_role.arn : var.prom_execution_role_arn
  task_role_arn = var.prom_task_role_arn == '' ? aws_iam_role.prometheus_role.arn : var.prom_task_role_arn
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = var.prom_cpu
  memory = var.prom_memory

  volume {
    name = "ecs-discovery"
  }

  container_definitions = jsonencode([
    {
      image = "tkgregory/prometheus-ecs-discovery:latest",
      name = "prometheus-ecs-discovery",
      logConfiguration = {
        logDriver = "awslogs",
        options =  {
          "awslogs-group": "/ecs/ecs-prometheus",
          "awslogs-region": var.region,
          "awslogs-stream-prefix": "prometheus-ecs-discovery"
        }
      },
      command =  [
        "-config.cluster=${var.cluster_name}",
        "-config.write-to=/output/ecs_file_sd.yml"
      ],
      mountPoints = [
        {
          containerPath = "/output"
          sourceVolume = "ecs-discovery"
        }
      ]
    },
    {
      image            = "ghcr.io/bruceharrison1984/ecomm-prometheus:v2.29.1",
      name             = "prometheus",
      logConfiguration = {
        logDriver = "awslogs",
        options   = {
          "awslogs-group" : "/ecs/ecs-prometheus",
          "awslogs-region" : var.region,
          "awslogs-stream-prefix" : "prometheus"
        }
      },
      environment = [
        {
          name  = "S3_CONFIG_LOCATION",
          value = "s3://${var.s3_bucket}/prometheus.yml"
        }
      ],
      mountPoints = [
        {
          containerPath = "/output"
          sourceVolume  = "ecs-discovery"
        }
      ]
    }
  ])
}