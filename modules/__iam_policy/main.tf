resource "aws_iam_policy" "policy" {
<<<<<<< HEAD
=======
  for_each = toset(var.policy)

>>>>>>> cbbb6cea38fe8ada970997e6ec3aa4aa102cb3a6
  name        = "${var.team}-${var.name}"
  path        = var.path
  description = "${var.name} policy for ${var.team}"

<<<<<<< HEAD
  policy = var.policy
=======
  policy = each.value
>>>>>>> cbbb6cea38fe8ada970997e6ec3aa4aa102cb3a6
}