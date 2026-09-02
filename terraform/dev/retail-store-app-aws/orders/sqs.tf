module "orders_queue" {
  source = "../../../../modules/__sqs"
  queue_name = "${var.team}-${var.environment}-gp-orders-queue"
  environment = "dev"
}