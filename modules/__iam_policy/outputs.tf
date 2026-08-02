output "arn" {
  value = {
    for k, v in aws_iam_policy.policy : k => v.arn
  }
}

output "id" {
  value = {
    for k, v in aws_iam_policy.policy : k => v.id
  }
}

output "description" {
  value = {
    for k, v in aws_iam_policy.policy : k => v.description
  }
}

output "name" {
  value = {
    for k, v in aws_iam_policy.policy : k => v.name
  }
}

output "policy" {
  value = {
    for k, v in aws_iam_policy.policy : k => v.policy
  }
}