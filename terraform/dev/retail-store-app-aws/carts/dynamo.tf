module "cart_table" {

  source = "../../../../modules/__dynamodb"

  team         = var.team
  env          = var.env
  name         = "Items"
  billing_mode = "PAY_PER_REQUEST"
  region      = "us-west-2"

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
      name            = "idx_global_customerId"
      hash_key        = "customerId"
      projection_type = "ALL"
    }
  ]

  tags = {
    Environment = var.env
    Team        = var.team
    Region      = "us-west-2"
  }
}