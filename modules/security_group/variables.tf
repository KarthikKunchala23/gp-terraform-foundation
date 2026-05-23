variable "team" {
  description = "Team responsible for the security group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
  default = ""
  
}

variable "ingress_with_cidr_blocks" {
  description = "List of ingress rules to create with CIDRs blocks"
  type = list(map(string))
  default = []
}

variable "egress_with_cidr_blocks" {
  description = "List of egress rules to create with CIDRs blocks"
  type = list(map(string))
  default = []
}

variable "ingress_with_prefix_list_ids" {
  description = "List of ingress rules to create with prefix list IDs"
  type = list(map(string))
  default = []
}

variable "create" {
  description = "Whether to create the security group or not"
  type        = bool
  default     = true
}

variable "computed_ingress_with_cidr_blocks" {
  description = "List of computed ingress rules to create with CIDRs blocks"
  type = list(map(string))
  default = []
}

variable "additional_rds_postgres_cidr" {
  description = "Additional CIDRs allowed to access PostgreSQL"
  type = list(string)
  default = []
}