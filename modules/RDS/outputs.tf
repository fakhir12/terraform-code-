output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.datab_subnet_group.endpoint
}

# output "rds_instance_id" {
#   description = "The ID of the RDS instance"
#   value       = aws_db_instance.database_instance.id
# }

