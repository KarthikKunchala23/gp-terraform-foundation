output "vpc_id" {
  description = "The ID of the VPC the application modules attach to"
  value       = module.retail_store_vpc.vpc_id
}
