variable "team" {
  type = string
  default = "gp-team"
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
    default     = "dev-rds-vpc" 
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

## RDS Variables
variable "rds_identifier" {
    description = "The name of the RDS instance."
    type = string 
    default = ""
}

variable "rds_engine" {
    description = "The database engine to use."
    type = string
    default = ""
}

variable "rds_engine_version" {
    description = "The version of the database engine to use."
    type = string
    default = ""
}

variable "rds_engine_lifecycle_support" {
    description = "Whether to enable lifecycle support for the database engine."
    type = string
    default = ""
}

variable "rds_family" {
    description = "The DB Parameter Group Family to use."
    type = string
    default = ""
}

variable "rds_major_engine_version" {
    description = "The DB Option Group Major Engine Version to use."
    type = string
    default = ""
}

variable "rds_instance_class" {
    description = "The instance type of the RDS instance."
    type = string
    default = ""
}

variable "rds_allocated_storage" {
    description = "The allocated storage in gigabytes."
    type = number
    default = 0
}

variable "rds_max_allocated_storage" {
    description = "The maximum allocated storage in gigabytes."
    type = number
    default = 0
}

variable "rds_db_name" {
    description = "The name of the database to create when the DB instance is created."
    type = string
    default = ""
}

variable "rds_username" {
    description = "The username for the database master user."
    type = string
    default = ""
}

variable "rds_ports" {
    description = "The port on which the DB instance will accept connections."
    type = number
    default = 5432
}

variable "rds_manage_master_user_password_rotation" {
    description = "Whether to manage master user password rotation."
    type = bool
    default = false
}

variable "rds_master_user_password_rotate_immediately" {
    description = "Whether to rotate the master user password immediately."
    type = bool
    default = false
}

variable "rds_master_user_password_rotation_schedule_expression" {
    description = "The schedule expression for rotating the master user password."
    type = string
    default = ""
}

variable "rds_multi_az" {
    description = "Whether to create a Multi-AZ DB instance."
    type = bool
    default = false
}

variable "rds_db_subnet_group_name" {
    description = "The name of the DB subnet group to use for the DB instance."
    type = string
    default = ""
}

variable "rds_vpc_security_group_ids" {
    description = "A list of VPC security groups to associate with the DB instance."
    type = list(string)
    default = []
}

variable "rds_maintenance_window" {
    description = "The weekly time range during which system maintenance can occur."
    type = string
    default = ""
}

variable "rds_backup_window" {
    description = "The daily time range during which automated backups are created."
    type = string
    default = ""
}

variable "rds_enabled_cloudwatch_logs_exports" {
    description = "A list of log types to export to CloudWatch Logs."
    type = list(string)
    default = []
}

variable "rds_create_cloudwatch_log_group" {
    description = "Whether to create a CloudWatch Log Group for the RDS instance."
    type = bool
    default = false
}

variable "rds_backup_retention_period" {
    description = "The number of days to retain automated backups."
    type = number
    default = 0
}


variable "rds_skip_final_snapshot" {
    description = "Whether to skip the final snapshot when deleting the DB instance."
    type = bool
    default = false
}

variable "rds_deletion_protection" {
    description = "Whether to enable deletion protection for the DB instance."
    type = bool
    default = false
}

variable "rds_performance_insights_enabled" {
    description = "Whether to enable Performance Insights for the DB instance."
    type = bool
    default = false
}

variable "rds_performance_insights_retention_period" {
    description = "The number of days to retain Performance Insights data."
    type = number
    default = 0
}

variable "rds_create_monitoring_role" {
    description = "Whether to create an IAM role for enhanced monitoring."
    type = bool
    default = false
}

variable "rds_monitoring_role_name" {
    description = "The name of the IAM role for enhanced monitoring."
    type = string
    default = ""
}

variable "rds_monitoring_interval" {
    description = "The interval, in seconds, between enhanced monitoring metrics collections."
    type = number
    default = 0
}

variable "rds_monitoring_role_use_name_prefix" {
    description = "Whether to use the monitoring role name as a prefix when creating the IAM role for enhanced monitoring."
    type = bool
    default = false
}

variable "rds_monitoring_role_description" {
    description = "The description of the IAM role for enhanced monitoring."
    type = string
    default = ""
}

variable "rds_parameters" {
    description = "A list of DB parameters to apply to the DB instance."
    type = list(object({
        name  = string
        value = string
    }))
    default = []
}

variable "rds_tags" {
    description = "A map of tags to assign to the DB instance."
    type = map(string)
    default = {}
}

variable "rds_db_option_group_tags" {
    description = "A map of tags to assign to the DB option group."
    type = map(string)
    default = {}
}

variable "rds_db_parameter_group_tags" {
    description = "A map of tags to assign to the DB parameter group."
    type = map(string)
    default = {}
}

variable "rds_cloudwatch_log_group_tags" {
    description = "A map of tags to assign to the CloudWatch Log Group."
    type = map(string)
    default = {}
}