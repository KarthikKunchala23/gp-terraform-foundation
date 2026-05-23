data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}

locals {
    name = "${var.team}-${var.vpc_name}"
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

module "rds_vpc" {
    source = "../../../modules/__vpc"

    vpc_name = local.name
    vpc_cidr = local.vpc_cidr
    availability_zones = local.availability_zones

    public_subnets  = [for i,j in local.availability_zones : cidrsubnet(local.vpc_cidr, 8, i + 1)]
    private_subnets = [for i,j in local.availability_zones : cidrsubnet(local.vpc_cidr, 8, i + 11)]
    database_subnets = [for i,j in local.availability_zones : cidrsubnet(local.vpc_cidr, 8, i + 21)]
    enable_nat_gateway = var.enable_nat_gateway
    single_nat_gateway = var.single_nat_gateway
    one_nat_gateway_per_az = var.one_nat_gateway_per_az

    create_database_subnet_group = var.create_database_subnet_group
    manage_default_route_table = var.manage_default_route_table
    customer_gateway_asn = var.customer_gateway_asn
    enable_vpn_gateway = var.enable_vpn_gateway
    tags = merge(local.tags, var.tags)
}