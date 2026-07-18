data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}

data "aws_secretsmanager_secret" "retail-store-db" {
    name = "retail-store-db-secret"
}

data "aws_secretsmanager_secret_version" "retail-store-db-version" {
  secret_id = data.aws_secretsmanager_secret.retail-store-db.id
}

locals {
    vpc_name = "${var.team}-${var.vpc_name}"
    rds_name = "${var.team}-rds-instance"
    # rds_password_secret_name = "catalog-app-team-rds-master-user-password"
    # rds_secret = jsondecode(data.aws_secretsmanager_secret_version.rds_master_user_password.secret_string)
    region = "ap-south-1"
    vpc_cidr = var.vpc_cidr
    availability_zones = slice(data.aws_availability_zones.available.names, 0, 3)
    retail_store_secret = jsondecode(data.aws_secretsmanager_secret_version.retail-store-db-version.secret_string)

    tags = {
        "Owner" = var.team
        "Environment" = var.environment
        "Project" = var.project
        "GitHubRepo" = "gp-terraform-foundation"
    }
}
