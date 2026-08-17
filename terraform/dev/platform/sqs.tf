module "karpenter_queue" {
  source = "../../../modules/__sqs"
  queue_name = "gp-eks-dev-cluster-karpenter-interruption"
  environment = "dev"
}