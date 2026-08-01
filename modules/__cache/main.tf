resource "aws_elasticache_cluster" "redis-cache" {
  cluster_id           = "${var.team}-${var.cluster_id}"
  engine               = "redis"
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = "default.redis7"
  engine_version       = "7.1"
  port                 = 6379
  security_group_ids  = var.security_group_ids
  subnet_group_name    = aws_elasticache_subnet_group.cache-subnet-group.name

  tags = {
    Name = "${var.team}-${var.cluster_id}"
  }
}

resource "aws_elasticache_subnet_group" "cache-subnet-group" {
  name       = "${var.team}-${var.cluster_id}-subnet-group"
  subnet_ids = var.subnet_ids
}