module "sg" {
  source  = "../../../modules/security_group"
  create = true
  team = var.team
  vpc_id = var.vpc_id
  ingress_with_cidr_blocks = [
    {
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        cidr_blocks = "10.40.224.0/23,10.24.171.0/25,10.75.128.252/32,10.75.128.253/32,10.75.128.251/32,10.75.128.250/32"
    }
  ]
  additional_rds_postgres_cidr = [
    "10.75.128.249/32",
    "10.75.128.220/32"
  ]
}