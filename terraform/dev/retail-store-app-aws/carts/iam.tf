# data "aws_iam_policy_document" "carts_dynamodb_policy" {
#   statement {
#     sid    = "CartsDynamoDBAccess"
#     effect = "Allow"

#     actions = [
#       "dynamodb:CreateTable",
#       "dynamodb:DeleteTable",
#       "dynamodb:DescribeTable",
#       "dynamodb:UpdateTable",
#       "dynamodb:PutItem",
#       "dynamodb:GetItem",
#       "dynamodb:DeleteItem",
#       "dynamodb:Query",
#       "dynamodb:Scan",
#       "dynamodb:BatchGetItem",
#       "dynamodb:BatchWriteItem",
#       "dynamodb:DescribeTimeToLive",
#       "dynamodb:ListTables",
#       "dynamodb:ListTagsOfResource"
#     ]

#     resources = [
#       module.cart_table.table_arn,
#       "${module.cart_table.table_arn}/index/*"
#     ]
#   }
# }

data "aws_iam_policy_document" "dynamo_assume_role" {
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

data "aws_iam_policy" "carts_dynamodb_policy" {
  name = "gp-carts-dynamodb_dev_carts"
}

# module "dynamo_policy" {
#   source = "../../../../modules/__iam_policy"
#   name = "dynamo-policy-retail-store"
#   team = var.team
  
#   policy = { carts_dynamodb_policy = data.aws_iam_policy_document.carts_dynamodb_policy.json }

#   path = "/carts/"
#   env = var.env
# }

module "dynamo_iam_role" {
  source = "../../../../modules/__iam_role"
  role_name = "gp-${var.team}-${var.env}-dynamodb-role"
  team = var.team
  assume_role_trust_policy = data.aws_iam_policy_document.dynamo_assume_role.json
  policy_arn = {
    carts_dynamodb_policy = data.aws_iam_policy.carts_dynamodb_policy.arn
  }
  env = var.env
}

resource "aws_eks_pod_identity_association" "carts" {
  cluster_name    = data.aws_eks_cluster.this.name
  namespace       = "default"
  service_account = "carts"
  role_arn        = module.dynamo_iam_role.iam_role_arn
}