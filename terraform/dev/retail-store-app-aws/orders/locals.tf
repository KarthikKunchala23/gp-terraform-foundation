data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}

data "aws_secretsmanager_secret" "retail-store-db" {
    name = "retail-store-db-secret"
}

data "aws_secretsmanager_secret_version" "retail-store-db-version" {
  secret_id = data.aws_secretsmanager_secret.retail-store-db.id
}

data "aws_vpc" "retail-vpc" {
  id = var.vpc_id
}

data "aws_subnets" "retail-snet" {
  filter {
    name = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Name = "retail-store-app-backend-vpc-db-*"
  }
}

locals {
    rds_name = "${var.team}-rds-instance"
    # rds_password_secret_name = "catalog-app-team-rds-master-user-password"
    # rds_secret = jsondecode(data.aws_secretsmanager_secret_version.rds_master_user_password.secret_string)
    region = "ap-south-1"
    availability_zones = slice(data.aws_availability_zones.available.names, 0, 3)
    retail_store_secret = jsondecode(data.aws_secretsmanager_secret_version.retail-store-db-version.secret_string)

    tags = {
        "Owner" = var.team
        "Environment" = var.environment
        "Project" = var.project
        "GitHubRepo" = "gp-terraform-foundation"
    }
}
