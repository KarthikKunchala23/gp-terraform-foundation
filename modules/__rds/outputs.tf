output "db_instance_address" {
  description = "The address of the RDS instance"
  value = module.rds.db_instance_address
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value = module.rds.db_instance_arn
}

output "db_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value = module.rds.db_instance_availability_zone
}

output "db_instance_cloudwatch_log_groups" {
  description = "The CloudWatch log groups associated with the RDS instance"
  value = module.rds.db_instance_cloudwatch_log_groups
}

output "db_instance_ca_cert_identifier" {
  description = "The CA certificate identifier for the RDS instance"
  value = module.rds.db_instance_ca_cert_identifier
}

output "db_instance_domain" {
  description = "The Active Directory domain of the RDS instance"
  value = module.rds.db_instance_domain
}

output "db_instance_domain_auth_secret_arn" {
  description = "The ARN of the secret used for Active Directory authentication for the RDS instance"
  value = module.rds.db_instance_domain_auth_secret_arn
}

output "db_instance_domain_dns_ips" {
  description = "The DNS IPs of the Active Directory domain for the RDS instance"
  value = module.rds.db_instance_domain_dns_ips
}

output "db_instance_domain_fqdn" {
  description = "The fully qualified domain name of the Active Directory domain for the RDS instance"
  value = module.rds.db_instance_domain_fqdn
}

output "db_instance_domain_iam_role_name" {
  description = "The name of the IAM role used for Active Directory authentication for the RDS instance"
  value = module.rds.db_instance_domain_iam_role_name
}

# output "db_instance_domain_output" {
#   description = "The organizational unit of the Active Directory domain for the RDS instance"
#   value = module.rds.db_instance_domain_ouput
# }

output "db_instance_endpoint" {
  description = "The endpoint of the RDS instance"
  value = module.rds.db_instance_endpoint
}

output "db_instance_engine" {
  description = "The database engine of the RDS instance"
  value = module.rds.db_instance_engine
}

output "db_instance_engine_version_actual" {
  description = "The actual database engine version of the RDS instance"
  value = module.rds.db_instance_engine_version_actual
}

output "db_instance_hosted_zone_id" {
  description = "The hosted zone ID of the RDS instance"
  value = module.rds.db_instance_hosted_zone_id
}

output "db_instance_identifier" {
  description = "The identifier of the RDS instance"
  value = module.rds.db_instance_identifier
}

output "db_instance_master_user_secret_arn" {
  description = "The ARN of the secret containing the master user password for the RDS instance"
  value = module.rds.db_instance_master_user_secret_arn
}

output "db_instance_name" {
  description = "The name of the database on the RDS instance"
  value = module.rds.db_instance_name
}

output "db_instance_port" {
  description = "The port on which the RDS instance accepts connections"
  value = module.rds.db_instance_port
}