module "cart_table" {

  source = "../../../../modules/__dynamodb"

  team         = var.team
  env          = var.env
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
    Environment = var.env
    Team        = var.team
    Region      = "ap-south-1"
  }
}