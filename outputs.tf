# # output "vpc_ids" {
# #   value = module.vpc.vpc_id
# # }
output "vpc_ids" {
  value = { for k, v in module.vpc : k => v.vpc_id }
}



output "db_sg_id" {
  value = { for k, v in module.security : k => v.db_sg_id }

}
# output "alb_sg_id" {
#   value = { for k, v in module.security : k => v.alb_sg_id }

# }
# # output "public_subnet_ids" {
# #   value = module.vpc.public_subnet_ids
# # }

# # output "private_subnet_ids" {
# #   value = module.vpc.private_subnet_ids
# # }
# output "public_subnet_ids" {
#   value = { for k, v in module.vpc : k => v.public_subnet_ids }
# }

# output "private_subnet_ids" {
#   value = { for k, v in module.vpc : k => v.private_subnet_ids }
# }

# output "target_group_arn" {
#   description = "ARN of the Target Group"
#   value       = { for k, v in module.ALB : k => v.target_group_arn }
# }

# # output "env" {
# #   value = var.env

# # }

# # output "region" {
# #   value = var.region

# # }

# # output "identifier" {
# #   value = var.identifier

# # }

# # # output "user_data" {
# # #   value = var.user_data

# # # }


# # output "high_cpu_alarm_arn" {
# #   value = module.Monitoring.high_cpu_alarm_arn
# # }

# # output "low_cpu_alarm_arn" {
# #   value = module.Monitoring.low_cpu_alarm_arn
# # }


# # output "asg_name" {
# #   value = module.ASG.asg_name

# # }

# # output "scale_out_policy_arn" {
# #   value = module.ASG.scale_out_policy_arn

# # }

# # output "scale_in_policy_arn" {
# #   value = module.ASG.scale_in_policy_arn

# # }

# # output "available_azs" {
# #   value = data.aws_availability_zones.available.names
# # }

