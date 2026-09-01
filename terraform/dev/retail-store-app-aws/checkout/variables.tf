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
  description = "The VPC ID for the cache cluster. Supplied by retail-store-tf-install.sh from the vpc module output."
  type        = string

  validation {
    condition     = can(regex("^vpc-[0-9a-f]+$", var.vpc_id))
    error_message = "vpc_id must be a VPC id such as vpc-0123456789abcdef0."
  }
}
