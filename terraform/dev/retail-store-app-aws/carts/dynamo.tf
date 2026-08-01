module "cart_table" {

  source = "../../../../modules/__dynamodb"

  team         = var.team
  environment  = var.environment
  name         = "dynamodb-table"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "id"

  attributes = [
    {
      name = "id"
      type = "S"
    },
    {
      name = "customerId"
      type = "S"
    }
  ]

  ttl = {
    enabled        = true
    attribute_name = "TimeToExist"
  }

  global_secondary_indexes = [
    {
      name            = "CustomerIndex"
      hash_key        = "customerId"
      projection_type = "ALL"
    }
  ]

  tags = {
    Environment = var.environment
    Team        = var.team
    Region      = "ap-south-1"
  }
}