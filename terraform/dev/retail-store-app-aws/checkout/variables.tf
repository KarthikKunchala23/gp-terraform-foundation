variable "team" {
  description = "The team responsible for the cache cluster"
  type        = string
  default     = "checkout"
}

variable "cluster_id" {
  description = "The ID of the cache cluster"
  type        = string
  default     = "redis-cache"
}

variable "node_type" {
  description = "The type of node to use for the cache cluster"
  type        = string
  default     = "cache.t3.micro"
}

variable "num_cache_nodes" {
  description = "The number of cache nodes to create"
  type        = number
  default     = 1
}

variable "environment" {
  description = "The environment for the cache cluster"
  type        = string
  default     = "dev"
}

variable "vpc_id" {
  description = "The VPC ID for the cache cluster"
  type        = string
  default     = "vpc-0b135162059269870"
}