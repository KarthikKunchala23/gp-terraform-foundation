module "checkout_redis" {
  source = "../../../../modules/__cache"

  team              = var.team
  cluster_id        = var.cluster_id
  node_type         = var.node_type
  num_cache_nodes   = var.num_cache_nodes
  security_group_ids = [module.checkout_redis_sg.security_group_id]
  subnet_ids        = data.aws_subnets.retail-snet.ids
}

module "checkout_redis_sg" {
  source  = "../../../../modules/security_group"
  create = true
  service = "checkout-redis"
  vpc_id = data.aws_vpc.retail-vpc.id
  ingress_with_cidr_blocks = [
    {
        from_port   = 6379
        to_port     = 6379
        protocol    = "tcp"
        cidr_blocks = "10.0.0.0/16"
    }
  ]

  egress_with_cidr_blocks = [ 
    {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = "0.0.0.0/0"
    }
   ]
}