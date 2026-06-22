## Secrets Manager for RDS Master User Password
# data "aws_secretsmanager_secret" "rds_master_user_password" {
#     name = "${local.rds_password_secret_name}"
# }

# data "aws_secretsmanager_secret_version" "rds_master_user_password" {
#     secret_id = data.aws_secretsmanager_secret.rds_master_user_password.id
# }

## RDS Module
module "db_mysql" {
    source = "../../../modules/__rds"
    rds_identifier = local.rds_name
    rds_engine = "mysql"
    rds_engine_version = "8.0"
    rds_engine_lifecycle_support = "open-source-rds-extended-support-disabled"
    rds_family = "mysql8.0"
    rds_major_engine_version = "8.0"
    rds_instance_class = "db.t4g.micro"

    rds_allocated_storage = 20
    rds_max_allocated_storage = 100
    rds_create_cloudwatch_log_group = true

    rds_db_name = "catalogdb"
    rds_username = "catalog"    # rds_password = local.rds_secret.password
    # rds_password_version = local.rds_secret.version
    rds_ports = 3306
    rds_publicly_accessible = true

    rds_manage_master_user_password_rotation = true
    rds_master_user_password_rotate_immediately = false
    rds_master_user_password_rotation_schedule_expression = "rate(30 days)"

    rds_multi_az = false
    rds_db_subnet_group_name = module.rds_vpc.database_subnet_group
    rds_vpc_security_group_ids = [module.sg.security_group_id]

    rds_maintenance_window = "Mon:00:00-Mon:03:00"
    rds_backup_retention_period = 7
    rds_backup_window = "03:00-04:00"
    rds_enabled_cloudwatch_logs_exports = ["error", "general", "slowquery"]

    rds_skip_final_snapshot = true
    rds_deletion_protection = false

    rds_performance_insights_enabled = false
    rds_performance_insights_retention_period = null
    rds_create_monitoring_role = true
    rds_monitoring_interval = 60
    rds_monitoring_role_name = "${local.rds_name}-monitoring-role"
    rds_monitoring_role_use_name_prefix = true
    rds_monitoring_role_description = "Monitoring role for ${local.rds_name} RDS instance"

    rds_parameters = [
        {
            name = "slow_query_log"
            value = "1"
            apply_method = "immediate"
        },
        {
            name = "long_query_time"
            value = "2"
            apply_method = "immediate"
        },
        {
            name = "log_output"
            value = "FILE"
            apply_method = "immediate"
        }
    ]

    rds_tags = local.tags

    rds_db_option_group_tags = {
        "Sensitive" = "low"
    }

    rds_db_parameter_group_tags = {
        "Sensitive" = "low"
    }

    rds_cloudwatch_log_group_tags = {
        "Sensitive" = "high"
    }

}
