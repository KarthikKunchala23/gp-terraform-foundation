# module "rds" {
#     source = "terraform-aws-modules/rds/aws"
#     version = "7.2.0"
#     identifier = var.rds_identifier
#     engine = var.rds_engine
#     engine_version = var.rds_engine_version
#     engine_lifecycle_support = var.rds_engine_lifecycle_support
#     family = var.rds_family # DB Parameter Group Family
#     major_engine_version = var.rds_major_engine_version # DB Option Group Major Engine Version
#     instance_class = var.rds_instance_class

#     allocated_storage = var.rds_allocated_storage
#     max_allocated_storage = var.rds_max_allocated_storage

#     db_name = var.rds_db_name
#     username = var.rds_username
#     password_wo = var.rds_password
#     # password_wo_version = var.rds_password_version
#     port = var.rds_ports
#     publicly_accessible = var.rds_publicly_accessible
    
#     manage_master_user_password_rotation = var.rds_manage_master_user_password_rotation
#     master_user_password_rotate_immediately = var.rds_master_user_password_rotate_immediately
#     master_user_password_rotation_schedule_expression = var.rds_master_user_password_rotation_schedule_expression

#     multi_az = var.rds_multi_az
#     db_subnet_group_name = var.rds_db_subnet_group_name
#     vpc_security_group_ids = var.rds_vpc_security_group_ids

#     maintenance_window = var.rds_maintenance_window
#     backup_window = var.rds_backup_window
#     enabled_cloudwatch_logs_exports = var.rds_enabled_cloudwatch_logs_exports
#     create_cloudwatch_log_group = var.rds_create_cloudwatch_log_group

#     backup_retention_period = var.rds_backup_retention_period
#     skip_final_snapshot = var.rds_skip_final_snapshot
#     deletion_protection = var.rds_deletion_protection

#     performance_insights_enabled = var.rds_performance_insights_enabled
#     performance_insights_retention_period = var.rds_performance_insights_retention_period
#     create_monitoring_role = var.rds_create_monitoring_role
#     monitoring_role_name = var.rds_monitoring_role_name
#     monitoring_interval = var.rds_monitoring_interval
#     monitoring_role_use_name_prefix = var.rds_monitoring_role_use_name_prefix
#     monitoring_role_description = var.rds_monitoring_role_description

#     parameters = var.rds_parameters

#     tags = var.rds_tags

#     db_option_group_tags = var.rds_db_option_group_tags
#     db_parameter_group_tags = var.rds_db_parameter_group_tags
#     cloudwatch_log_group_tags = var.rds_cloudwatch_log_group_tags
# }

# RDS subnet group
# resource "aws_db_subnet_group" "this" {
#   name       = "${var.name}-subnet-group"
#   subnet_ids = var.subnet_ids
# }


# RDS Instance
resource "aws_db_instance" "this" {
  identifier              = var.name
  engine                  = var.engine
  db_name                 = var.db_name
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  max_allocated_storage   = var.max_allocated_storage
  username                = var.username
  password                = var.password
  db_subnet_group_name    = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids  = var.security_group_ids
  skip_final_snapshot     = true    
  publicly_accessible     = false
  
}

resource "aws_db_subnet_group" "subnet_group" {
  name = var.db_subnet_group_name
  subnet_ids = var.db_subnet_ids 

  tags = {
    Name = var.db_subnet_group_name
  }
}