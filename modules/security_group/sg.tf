locals {
  vpc_id = var.vpc_id
  github_runners_ingress = [
    {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = "10.30.152.128/26,10.24.118.0/24"
        description = "Allow GitHub runners to access RDS instances"
    }
  ]
}

module "gp_rds_sg" {
  source  = "../__security_groups"
  name    = "${var.team}-rds-sg"
  description = "Security group for RDS instances in ${var.team} environment"
  vpc_id = local.vpc_id
  ingress_with_cidr_blocks = concat(local.github_runners_ingress, var.ingress_with_cidr_blocks)
  egress_with_cidr_blocks = var.egress_with_cidr_blocks
  ingress_with_prefix_list_ids = var.ingress_with_prefix_list_ids
  create = var.create
  computed_ingress_with_cidr_blocks = [
    for cidr in var.additional_rds_postgres_cidr : {
        rule  = "postgresql-tcp"
        cidr_blocks = cidr
    }
  ]
}