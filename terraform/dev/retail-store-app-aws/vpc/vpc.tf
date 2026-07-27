module "retail_store_vpc" {
    source = "../../../../modules/__vpc"

    vpc_name = local.vpc_name
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