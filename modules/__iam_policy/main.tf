resource "aws_iam_policy" "policy" {
  name        = "${var.team}-${var.name}"
  path        = var.path
  description = "${var.name} policy for ${var.team}"

  policy = var.policy
}