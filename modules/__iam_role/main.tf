resource "aws_iam_role" "role" {
  name = "${var.team}-${var.role_name}"
  assume_role_policy = var.assume_role_trust_policy
}

resource "aws_iam_role_policy_attachment" "attachment" {
  for_each = var.policy_arn

  role = aws_iam_role.role.name
  policy_arn = each.value
}