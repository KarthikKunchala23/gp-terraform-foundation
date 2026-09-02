# data "aws_iam_policy_document" "orders_sqs_policy" {
#   statement {
#     sid = "OrdersSQSAccess"
#     effect = "Allow"

#     actions = [
#           "sqs:SendMessage",
#           "sqs:ReceiveMessage",
#           "sqs:DeleteMessage",
#           "sqs:GetQueueAttributes",
#           "sqs:GetQueueUrl",
#           "sqs:ListQueues",
#           "sqs:PurgeQueue"
#     ]

#     resources = [ 
#         module.orders_queue.sqs_queue_arn
#      ]
#   }
# }


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

data "aws_iam_policy" "orders_secrets_policy" {
  name = "gp-orders-db-secret-manager-policy_dev_orders"
}

data "aws_iam_policy" "orders_sqs_policy" {
  name = "gp-orders-sqs-queue-policy_dev_orders"
}


# module "sqs_policy" {
#   source = "../../../../modules/__iam_policy"
#   name = "sqs-policy-retail-store"
#   team = var.team
  
#   policy = { orders_sqs_policy = data.aws_iam_policy_document.orders_sqs_policy.json }

#   path = "/orders/"
#   env = var.env
# }

module "sqs_iam_role" {
  source = "../../../../modules/__iam_role"
  role_name = "gp-${var.team}-${var.environment}-role"
  team = var.team
  assume_role_trust_policy = data.aws_iam_policy_document.assume_role.json
  policy_arn = {
    orders_secrets_policy = data.aws_iam_policy.orders_secrets_policy.arn,
    orders_sqs_policy = data.aws_iam_policy.orders_sqs_policy.arn
  }
  env = var.env
}

resource "aws_eks_pod_identity_association" "orders_pia" {
  cluster_name    = data.aws_eks_cluster.this.name
  namespace       = "default"
  service_account = "orders"
  role_arn        = module.sqs_iam_role.iam_role_arn
}