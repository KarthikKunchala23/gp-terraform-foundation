variable "team" {
  type = string
  default = "retail-store-app"
}

variable "env" {
  type = string
  default = null
}

variable "vpc_id" {
  description = "vpc id for sg"
  type = string
  default = ""
}

## VPC Variables
variable "vpc_name" {
    description = "Name of the VPC"
    type        = string
    default     = "backend-vpc" 
}

variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
}

variable "availability_zones" {
    description = "List of availability zones to use for the subnets"
    type        = list(string)
    default     = []
}

variable "public_subnets" {
    description = "List of CIDR blocks for public subnets"
    type        = list(string)
    default     = []
}

variable "private_subnets" {
    description = "List of CIDR blocks for private subnets"
    type        = list(string)
    default     = []
}

variable "database_subnets" {
    description = "List of CIDR blocks for database subnets"
    type        = list(string)
    default     = []
}

variable "enable_nat_gateway" {
    description = "Whether to enable NAT Gateway or not"
    type        = bool
    default     = false
}

variable "single_nat_gateway" {
    description = "Whether to use a single NAT Gateway for all AZs or not"
    type        = bool
    default     = false
}

variable "one_nat_gateway_per_az" {
    description = "Whether to create one NAT Gateway per AZ or not"
    type        = bool
    default     = false
}

variable "create_database_subnet_group" {
    description = "Whether to create a database subnet group or not"
    type        = bool
    default     = true
}

variable "manage_default_route_table" {
    description = "Whether to manage the default route table or not"
    type        = bool
    default     = false
}

variable "customer_gateway_asn" {
    description = "ASN for the customer gateway"
    type        = number
    default     = 65000
}

variable "enable_vpn_gateway" {
    description = "Whether to enable VPN Gateway or not"
    type        = bool
    default     = false
}

variable "tags" {
    description = "A map of tags to add to all resources"
    type        = map(string)
    default     = {}
}

variable "manage_default_security_group" {
    description = "Whether to manage the default security group or not"
    type        = bool
    default     = false
}

variable "manage_default_network_acl" {
    description = "Whether to manage the default network ACL or not"
    type        = bool
    default     = false
}

variable "environment" {
    description = "Environment name for tagging purposes"
    type        = string
    default     = "dev"
}

variable "project" {
    description = "Project name for tagging purposes"
    type        = string
    default     = "gp-project"
}