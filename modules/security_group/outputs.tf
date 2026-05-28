output "security_group_id" {
  description = "The security group id"
  value = module.gp_rds_sg.security_group_id
}