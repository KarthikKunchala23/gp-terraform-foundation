module "rds" {
    source = "terraform-aws-modules/rds/aws"
    version = "7.2.0"
    identifier = var.rds_identifier
    engine = var.rds_engine
    engine_version = var.rds_engine_version
    engine_lifecycle_support = var.rds_engine_lifecycle_support
    family = var.rds_family # DB Parameter Group Family
    major_engine_version = var.rds_major_engine_version # DB Option Group Major Engine Version
    instance_class = var.rds_instance_class

    allocated_storage = var.rds_allocated_storage
    max_allocated_storage = var.rds_max_allocated_storage

    db_name = var.rds_db_name
    username = var.rds_username
    port = var.rds_ports
    
    manage_master_user_password_rotation = var.rds_manage_master_user_password_rotation
    master_user_password_rotate_immediately = var.rds_master_user_password_rotate_immediately
    master_user_password_rotation_schedule_expression = var.rds_master_user_password_rotation_schedule_expression

    multi_az = var.rds_multi_az
    db_subnet_group_name = var.rds_db_subnet_group_name
    vpc_security_group_ids = var.rds_vpc_security_group_ids

    maintenance_window = var.rds_maintenance_window
    backup_window = var.rds_backup_window
    enabled_cloudwatch_logs_exports = var.rds_enabled_cloudwatch_logs_exports
    create_cloudwatch_log_group = var.rds_create_cloudwatch_log_group

    backup_retention_period = var.rds_backup_retention_period
    skip_final_snapshot = var.rds_skip_final_snapshot
    deletion_protection = var.rds_deletion_protection

    performance_insights_enabled = var.rds_performance_insights_enabled
    performance_insights_retention_period = var.rds_performance_insights_retention_period
    create_monitoring_role = var.rds_create_monitoring_role
    monitoring_role_name = var.rds_monitoring_role_name
    monitoring_interval = var.rds_monitoring_interval
    monitoring_role_use_name_prefix = var.rds_monitoring_role_use_name_prefix
    monitoring_role_description = var.rds_monitoring_role_description

    parameters = var.rds_parameters

    tags = var.rds_tags

    db_option_group_tags = var.rds_db_option_group_tags
    db_parameter_group_tags = var.rds_db_parameter_group_tags
    cloudwatch_log_group_tags = var.rds_cloudwatch_log_group_tags
}