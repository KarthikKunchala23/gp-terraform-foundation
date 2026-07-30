output "iam_role_arn" {
  value = try(aws_iam_role.role.arn, "")
}

output "iam_role_name" {
  value = try(aws_iam_role.role.name, "")
}