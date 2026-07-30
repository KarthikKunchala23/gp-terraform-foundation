data "aws_iam_policy_document" "orders_sqs_policy" {
  statement {
    sid = "OrdersSQSAccess"
    effect = "Allow"

    actions = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl",
          "sqs:ListQueues",
          "sqs:PurgeQueue"
    ]

    resources = [ 
        module.orders_queue.orders_sqs_queue_arn
     ]
  }
}


data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}


module "sqs_policy" {
  source = "../../../../modules/__iam_policy"
  name = "sqs-policy-retail-store"
  team = var.team
  policy = [data.aws_iam_policy_document.orders_sqs_policy.json]
  path = "/orders/"
  env = var.env
}

module "sqs_iam_role" {
  source = "../../../../modules/__iam_role"
  role_name = "sqs-role"
  team = var.team
  assume_role_trust_policy = data.aws_iam_policy_document.assume_role.json
  policy_arn = [ module.sqs_policy.arn ]
  env = var.env
}