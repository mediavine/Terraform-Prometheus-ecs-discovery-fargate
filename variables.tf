variable "prom_execution_role_arn" {
  type        = string
  description = "task execution role arn"
  default     = ""
}

variable "prom_task_role_arn" {
  type        = string
  description = "task role arn"
  default     = ""
}

variable "prom_cpu" {
  type        = number
  description = "cpu for the container"
  default     = 1024
}

variable "prom_memory" {
  type        = number
  description = "memory for the container"
  default     = 2048
}

variable "region" {
  type        = string
  description = "aws region"
}

variable "cluster_name" {
  type        = string
  description = "name of the ecs cluster"
}

variable "s3_bucket" {
  type        = string
  description = "name of s3 bucket that contains prometheus config"
}

variable "AMP_resource_arn" {
  type        = string
  description = "arn of AMP (Amazon Managed Prometheus) workspace"
}

variable "environment" {
  type        = string
  description = "environment of your application. i.e staging, production, etc."
}

variable "name_prefix" {
  type        = string
  description = "typically the name of the service or app"
  default     = "prometheus"
}

variable "prom_desired_count" {
  type        = number
  description = "number of tasks to run for this service"
  default     = 1
}

variable "platform_version" {
  type        = string
  description = "fargate version"
  default     = "1.4.0"
}

variable "subnets" {
  type    = list(any)
  default = []
}

variable "security_groups" {
  type    = list(any)
  default = []
}

variable "assign_public_ip" {
  type    = bool
  default = true
}