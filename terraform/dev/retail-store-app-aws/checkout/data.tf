data "aws_vpc" "retail-vpc" {
  id = var.vpc_id
}

data "aws_subnets" "retail-snet" {
  filter {
    name = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Name = "retail-store-app-backend-vpc-private-*"
  }
}