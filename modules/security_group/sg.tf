data "aws_vpc" "retail-vpc" {
  id = var.vpc_id
}

locals {
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

module "gp_sg" {
  source  = "../__security_groups"
  name    = "${var.service}-sg"
  description = "Security group for ${var.service}"
  vpc_id = data.aws_vpc.retail-vpc.id
  ingress_with_cidr_blocks = concat(local.github_runners_ingress, var.ingress_with_cidr_blocks)
  egress_with_cidr_blocks = var.egress_with_cidr_blocks
  ingress_with_prefix_list_ids = var.ingress_with_prefix_list_ids
  create = var.create
  # computed_ingress_with_cidr_blocks = concat(
  #   [for cidr in var.additional_rds_mysql_cidr : {
  #     rule       = "mysql-tcp"
  #     cidr_blocks = cidr
  #   }],
  #   [for cidr in var.additional_rds_postgres_cidr : {
  #     rule       = "postgresql-tcp"
  #     cidr_blocks = cidr
  #   }],
  # )
}