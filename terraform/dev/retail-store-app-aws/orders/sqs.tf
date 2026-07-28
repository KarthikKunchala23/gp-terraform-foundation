module "orders_queue" {
  source = "../../../../modules/__sqs"
  queue_name = "orders-sqs"
  environment = "dev"
}