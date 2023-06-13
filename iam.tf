resource "aws_iam_role" "prometheus_role" {
  name = "${var.environment}-${var.name_prefix}-role"
  assume_role_policy = aws_iam_policy.prom_read_write_policy.policy

  depends_on = [aws_iam_policy.prom_read_write_policy]
}

resource "aws_iam_policy" "prom_read_write_policy" {
  name = "${var.environment}-${var.name_prefix}-ecs-prom-policy"
  path = "/"
  description = "Policy to allow ecs discovery of prometheus metrics and writes to AMP"

  policy = templatefile("${path.module}/policies/prometheus-amp.json", {
    account_id = data.aws_caller_identity.current.account_id
    region = var.region
    cluster = var.cluster_name
    s3_bucket = var.s3_bucket
  })
}