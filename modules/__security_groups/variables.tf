variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Description of the security group"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
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