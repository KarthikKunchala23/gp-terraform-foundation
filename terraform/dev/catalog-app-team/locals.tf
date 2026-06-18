data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}

locals {
    vpc_name = "${var.team}-${var.vpc_name}"
    rds_name = "${var.team}-rds-instance"
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
