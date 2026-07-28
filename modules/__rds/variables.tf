# variable "rds_identifier" {
#     description = "The name of the RDS instance."
#     type = string 
# }

# variable "rds_engine" {
#     description = "The database engine to use."
#     type = string
# }

# variable "rds_engine_version" {
#     description = "The version of the database engine to use."
#     type = string
# }

# variable "rds_engine_lifecycle_support" {
#     description = "Whether to enable lifecycle support for the database engine."
#     type = string
# }

# variable "rds_family" {
#     description = "The DB Parameter Group Family to use."
#     type = string
# }

# variable "rds_major_engine_version" {
#     description = "The DB Option Group Major Engine Version to use."
#     type = string
# }

# variable "rds_instance_class" {
#     description = "The instance type of the RDS instance."
#     type = string
# }

# variable "rds_allocated_storage" {
#     description = "The allocated storage in gigabytes."
#     type = number
# }

# variable "rds_max_allocated_storage" {
#     description = "The maximum allocated storage in gigabytes."
#     type = number
# }

# variable "rds_db_name" {
#     description = "The name of the database to create when the DB instance is created."
#     type = string
# }

# variable "rds_username" {
#     description = "The username for the database master user."
#     type = string
# }

# variable "rds_password" {
#     description = "The password for the database master user."
#     type = string
#     sensitive = true
# }

# variable "rds_ports" {
#     description = "The port on which the DB instance will accept connections."
#     type = number
# }

# variable "rds_manage_master_user_password_rotation" {
#     description = "Whether to manage master user password rotation."
#     type = bool
# }

# variable "rds_master_user_password_rotate_immediately" {
#     description = "Whether to rotate the master user password immediately."
#     type = bool
# }

# variable "rds_master_user_password_rotation_schedule_expression" {
#     description = "The schedule expression for rotating the master user password."
#     type = string
# }

# variable "rds_multi_az" {
#     description = "Whether to create a Multi-AZ DB instance."
#     type = bool
# }

# variable "rds_db_subnet_group_name" {
#     description = "The name of the DB subnet group to use for the DB instance."
#     type = string
# }

# variable "rds_vpc_security_group_ids" {
#     description = "A list of VPC security groups to associate with the DB instance."
#     type = list(string)
# }

# variable "rds_maintenance_window" {
#     description = "The weekly time range during which system maintenance can occur."
#     type = string
# }

# variable "rds_backup_window" {
#     description = "The daily time range during which automated backups are created."
#     type = string
# }

# variable "rds_enabled_cloudwatch_logs_exports" {
#     description = "A list of log types to export to CloudWatch Logs."
#     type = list(string)
# }

# variable "rds_create_cloudwatch_log_group" {
#     description = "Whether to create a CloudWatch Log Group for the RDS instance."
#     type = bool
# }

# variable "rds_backup_retention_period" {
#     description = "The number of days to retain automated backups."
#     type = number
# }

# variable "rds_skip_final_snapshot" {
#     description = "Whether to skip the final snapshot when deleting the DB instance."
#     type = bool
# }

# variable "rds_deletion_protection" {
#     description = "Whether to enable deletion protection for the DB instance."
#     type = bool
# }

# variable "rds_performance_insights_enabled" {
#     description = "Whether to enable Performance Insights for the DB instance."
#     type = bool
# }

# variable "rds_performance_insights_retention_period" {
#     description = "The number of days to retain Performance Insights data."
#     type = number
# }

# variable "rds_create_monitoring_role" {
#     description = "Whether to create an IAM role for enhanced monitoring."
#     type = bool
# }

# variable "rds_monitoring_role_name" {
#     description = "The name of the IAM role for enhanced monitoring."
#     type = string
# }

# variable "rds_monitoring_interval" {
#     description = "The interval, in seconds, between enhanced monitoring metrics collections."
#     type = number
# }

# variable "rds_monitoring_role_use_name_prefix" {
#     description = "Whether to use the monitoring role name as a prefix when creating the IAM role for enhanced monitoring."
#     type = bool
# }

# variable "rds_monitoring_role_description" {
#     description = "The description of the IAM role for enhanced monitoring."
#     type = string
# }

# variable "rds_parameters" {
#     description = "A list of DB parameters to apply to the DB instance."
#     type = list(object({
#         name  = string
#         value = string
#     }))
# }

# variable "rds_tags" {
#     description = "A map of tags to assign to the DB instance."
#     type = map(string)
# }

# variable "rds_db_option_group_tags" {
#     description = "A map of tags to assign to the DB option group."
#     type = map(string)
# }

# variable "rds_db_parameter_group_tags" {
#     description = "A map of tags to assign to the DB parameter group."
#     type = map(string)
# }

# variable "rds_cloudwatch_log_group_tags" {
#     description = "A map of tags to assign to the CloudWatch Log Group."
#     type = map(string)
# }

# variable "rds_publicly_accessible" {
#     description = "Whether the DB instance is publicly accessible."
#     type = bool
# }

# # variable "rds_password_version" {
# #     description = "The version of the RDS master user password to use. This is used for password rotation."
# #     type = string
# # }

variable "name" {
  description = "Name/identifier for the RDS instance"
  type        = string
}

variable "engine" {
  description = "RDS Enginee to be selected"
  type = string
}

variable "engine_version" {
  description = "rds engine version"
  type        = string
}

variable "instance_class" {
  description = "DB instance class"
  type        = string
  default     = "db.t3.medium"
}

variable "allocated_storage" {
  description = "Initial storage in GB"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Max autoscaled storage"
  type        = number
  default     = 100
}

variable "username" {
  description = "DB master username"
  type        = string
}



# variable "subnet_ids" {
#   description = "List of private subnet IDs"
#   type        = list(string)
# }


variable "vpc_id" {
  description = "VPC ID where RDS will be deployed"
  type        = string
}


variable "password" {
  description = "Airflow DB password from SSM"
  type        = string
  sensitive = true
}

variable "db_name" {
  description = "Initial database name"
  type        = string  
}

variable "security_group_ids" {
  description = "Security Group ID for RDS"
  type = list(string)
}

# variable "db_subnet_group" {
#   description = "subnet group for db"
#   type = string
# }

variable "db_subnet_group_name" {
  description = "Name of the Database Subnet Groups"
  type = string
}

variable "db_subnet_ids" {
  description = "Subnet IDs of the Database"
  type = list(string)
}