module "mysql-rds-sg" {
  source  = "../../../../modules/security_group"
  create = true
  service = "rds-msql-catalog"
  vpc_id = data.aws_vpc.retail-vpc-catalog.id
  ingress_with_cidr_blocks = [
    {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = "10.40.224.0/23,10.24.171.0/25,10.75.128.252/32,10.75.128.253/32,10.75.128.251/32,10.75.128.250/32"
    }
  ]
  # additional_rds_mysql_cidr = [
  #   "10.0.0.0/16"
  # ]
}