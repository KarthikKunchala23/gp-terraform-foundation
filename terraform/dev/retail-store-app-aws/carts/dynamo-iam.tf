data "aws_iam_policy_document" "carts_dynamodb_policy" {
    statement {
        sid = "CartsDynamoDBAccess"
        effect = "Allow"

        actions = [
          "dynamodb:CreateTable",
          "dynamodb:DeleteTable",
          "dynamodb:DescribeTable",
          "dynamodb:UpdateTable",
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:UpdateItem",
          "dynamodb:BatchGetItem",
          "dynamodb:BatchWriteItem",
          "dynamodb:DescribeTimeToLive",
          "dynamodb:ListTables",
          "dynamodb:ListTagsOfResource"
        ]

        resources = [ 
            module.cart_table.table_arn
         ]
    }
}

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

module "dynamo_policy" {
  source = "../../../../modules/__iam_policy"
  name = "dynamo-policy-retail-store"
  team = var.team
  
  policy = { carts_dynamodb_policy = data.aws_iam_policy_document.carts_dynamodb_policy.json }

  path = "/carts/"
  env = var.env
}

module "dynamo_iam_role" {
  source = "../../../../modules/__iam_role"
  role_name = "dynamo-role"
  team = var.team
  assume_role_trust_policy = data.aws_iam_policy_document.dynamo_assume_role.json
  policy_arn = module.dynamo_policy.arn
  env = var.env
}