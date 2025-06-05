
output "vpc_ids" {
  value = { for k, v in module.vpc : k => v.vpc_id }
}



output "db_sg_id" {
  value = { for k, v in module.security : k => v.db_sg_id }

}


# output "rds_endpoint" {
#   description = "The endpoint of the RDS instance"
#   value       = aws_db_instance.datab_subnet_group.endpoint
# }