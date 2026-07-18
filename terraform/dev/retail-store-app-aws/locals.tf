data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}

locals {
    vpc_name = "${var.team}-${var.vpc_name}"
    rds_name = "${var.team}-rds-instance"
    # rds_password_secret_name = "catalog-app-team-rds-master-user-password"
    # rds_secret = jsondecode(data.aws_secretsmanager_secret_version.rds_master_user_password.secret_string)
    region = "ap-south-1"
    vpc_cidr = var.vpc_cidr
    availability_zones = slice(data.aws_availability_zones.available.names, 0, 3)

    tags = {
        "Owner" = var.team
        "Environment" = var.environment
        "Project" = var.project
        "GitHubRepo" = "gp-terraform-foundation"
    }
}
