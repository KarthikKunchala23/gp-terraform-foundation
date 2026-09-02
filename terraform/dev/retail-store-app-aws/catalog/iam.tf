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


data "aws_iam_policy" "catalog_secrets_policy" {
  name = "gp-catalog-db-secret-manager-policy_dev_catalog"
}

module "catalog_iam_role" {
  source = "../../../../modules/__iam_role"
  role_name = "gp-${var.team}-${var.environment}-role"
  team = var.team
  assume_role_trust_policy = data.aws_iam_policy_document.assume_role.json
  policy_arn = {
    catalog_secrets_policy = data.aws_iam_policy.catalog_secrets_policy.arn
  }
  env = var.env
}

resource "aws_eks_pod_identity_association" "catalog" {
  cluster_name    = data.aws_eks_cluster.this.name
  namespace       = "default"
  service_account = "catalog"
  role_arn        = module.catalog_iam_role.iam_role_arn
}