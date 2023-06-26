#resource "aws_iam_role" "prometheus_role" {
#  name               = "${var.environment}-${var.name_prefix}-role"
#  assume_role_policy = <<EOF
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Action": "sts:AssumeRole",
#      "Principal": {
#        "Service": "ecs:*"
#      },
#      "Effect": "Allow",
#      "Sid": ""
#    }
#  ]
#}
#EOF
#}
#
#resource "aws_iam_policy" "prom_read_write_policy" {
#  name        = "${var.environment}-${var.name_prefix}-ecs-prom-policy"
#  path        = "/"
#  description = "Policy to allow ecs discovery of prometheus metrics and writes to AMP"
#
#  policy = templatefile("${path.module}/policies/prometheus-amp.json", {
#    account_id       = data.aws_caller_identity.current.account_id
#    region           = var.region
#    cluster_name     = var.cluster_name
#    s3_bucket        = var.s3_bucket
#    AMP_resource_arn = var.AMP_resource_arn
#  })
#}
#
#resource "aws_iam_role_policy_attachment" "ecs_prom_policy_attachment" {
#  policy_arn = aws_iam_policy.prom_read_write_policy.arn
#  role       = aws_iam_role.prometheus_role.arn
#}