variable "env" {}
variable "identifier" {}
variable "region" {}

variable "ecs_instance_type" {}
variable "key_name" {}

variable "vpc_id" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "wordpress_sg_id" {}

variable "rds_endpoint" {}



variable "asg_desired_capacity" {}
variable "asg_max_size" {}
variable "asg_min_size" {}
variable "asg_health_check_type" {}
variable "lt_associate_public_ip_address" {
  
}
variable "lt_version" {
  
}
variable "task_defination_family" {
  
}
variable "task_requires_compatibilities" {
  
}
variable "task_network_mode" {
  
}
variable "container_cpu" {
  
}
variable "container_memory" {
  
}
variable "container_name" {
  
}
variable "container_ecr_image" {
  
}
variable "container_port" {
  
}
variable "container_host_port" {
  
}
variable "service_name" {
  
}
variable "service_desired_count" {
  
}
variable "service_launch_type" {
  
}
variable "service_deployment_minimum_healthy_percent" {
  
}
variable "service_deployment_maximum_percent" {
  
}
variable "cluster_name" {
  
}
variable "lt_name" {
  
}
variable "instance_name" {
  
}

variable "target_group_arn" {}
variable "alb_arn" {}


variable "rds_secret_arn" {
  type        = string
  description = "ARN of the RDS secret in Secrets Manager"
}

variable "secret_username" {
  
}
variable "secret_db_name" {
  
}
variable "secret_password" {
  type        = string
  description = "RDS password, should be set via Secrets Manager"
}