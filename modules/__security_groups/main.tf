module "security-group" {
source  = "terraform-aws-modules/security-group/aws"
version = "5.2.0"
name    = var.name
description = var.description
vpc_id = var.vpc_id
ingress_with_cidr_blocks = var.ingress_with_cidr_blocks
egress_with_cidr_blocks = var.egress_with_cidr_blocks
ingress_with_prefix_list_ids = var.ingress_with_prefix_list_ids
create = var.create
computed_ingress_with_cidr_blocks = var.computed_ingress_with_cidr_blocks
number_of_computed_ingress_with_cidr_blocks = length(var.computed_ingress_with_cidr_blocks)
}