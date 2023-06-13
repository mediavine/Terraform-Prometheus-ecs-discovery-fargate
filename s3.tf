resource "aws_s3_bucket" "prometheus_configs" {
  bucket = "${var.cluster_name}-prom-configs"
}