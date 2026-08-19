module "karpenter_queue" {
  source = "../../../modules/__sqs"
  queue_name = "gp-eks-dev-cluster-karpenter-interruption"
  environment = "dev"
}

resource "aws_sqs_queue_policy" "karpenter_interruption" {
  queue_url = module.karpenter_queue.karpenter_sqs_queue_url
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = ["events.amazonaws.com", "sqs.amazonaws.com"]
        }
        Action   = "sqs:SendMessage"
        Resource = module.karpenter_queue.karpenter_sqs_queue_arn
      },
      {
        Sid      = "DenyHTTP"
        Effect   = "Deny"
        Action   = "sqs:*"
        Resource = module.karpenter_queue.karpenter_sqs_queue_arn
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
        Principal = "*"
      }
    ]
  })
}