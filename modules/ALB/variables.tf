variable "region" {}

variable "env" {}

variable "identifier" {}

variable "vpc_id" {
  type = string
}

variable "alb_sg_id" {
  
}

variable "internal" {
  
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "enable_deletion_protection" {
  
}

variable "alb_name" {}

variable "load_balancer_type" {
  
}

variable "target_group_name" {
  
}

variable "alb_listener_port" {
  
}
variable "target_group_protocol" {
  
}

variable "alb_listener_type" {
  
}