variable "team" {
  description = "The team responsible for the cache cluster"
  type        = string
}

variable "cluster_id" {
  description = "The ID of the cache cluster"
  type        = string
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

variable "security_group_ids" {
  description = "A list of security group IDs to associate with the cache cluster"
  type        = list(string)
}

variable "subnet_ids" {
  description = "A list of subnet IDs to associate with the cache cluster"
  type        = list(string)
}