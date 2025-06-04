


# # # ################################################################################################
# # # ###################################    vpc       ###############################################
# # # #################################################################################################


variable "vpcs" {
  description = "VPC configuration"
  type = list(object({
    name                                   = string
    vpc_cidr                               = string
    identifier                             = string
    region                                 = string
    env                                    = string
    public_subnet_name_pattern             = string
    private_subnet_name_pattern            = string
    create_igw                             = bool
    private_subnet_map_public_ip_on_launch = bool
    public_subnet_map_public_ip_on_launch  = bool
    public_subnet_cidr_start               = number
    private_subnet_cidr_start              = number
    subnet_newbits                         = number

  }))
}


# # # ################################################################################################
# # # ################################     Security     ##############################################
# # # #################################################################################################

variable "security_groups" {
  description = "Security configuration"
  type = list(object({

    ingress_description  = string
    cidr_blocks          = list(string)
    egress_protocol      = number
    ingress_protocol     = string
    egress_description   = string
    identifier           = string
    region               = string
    env                  = string
    ingress_ports        = list(string)
    egress_ports         = list(string)
    public_cidr_blocks   = list(string)
    alb_egress_protocol  = string
    alb_ingress_protocol = string



  }))

}



# # ################################################################################################
# # ################################     RDS          ##############################################
# # #################################################################################################


variable "RDS" {
  type = list(object({
    name                 = string
    allocated_storage    = number
    storage_type         = string
    engine               = string
    engine_version       = string
    instance_class       = string
    parameter_group_name = string
    egress_protocol      = number
    env                  = string
    skip_final_snapshot  = bool
    identifier           = string

  }))

}
variable "rds_db_name" {

}
variable "rds_username" {

}




# # ################################################################################################
# # ################################     ALB          ##############################################
# # #################################################################################################




variable "ALB" {
  description = "ALB configuration"
  type = list(object({
    alb_name                         = string
    load_balancer_type               = string
    target_group_name                = string
    alb_listener_port                = number
    target_group_protocol            = string
    alb_listener_type                = string
    identifier                       = string
    region                           = string
    env                              = string
    alb_egress_protocol              = string
    enable_deletion_protection       = bool
    internal                         = bool
    health_check_path                = string
    health_check_protocol            = string
    health_check_healthy_threshold   = number
    health_check_unhealthy_threshold = number
    health_check_timeout             = number
    health_check_interval            = number
    health_check_matcher             = string
  }))


}


# ################################################################################################
# ################################     ecs          ##############################################
# #################################################################################################




variable "ECS" {
  description = "ECS cluster and instance configuration list"
  type = list(object({
    env                                        = string
    identifier                                 = string
    region                                     = string
    ecs_instance_type                          = string
    egress_protocol                            = number
    lt_associate_public_ip_address             = bool
    asg_desired_capacity                       = number
    asg_max_size                               = number
    asg_min_size                               = number
    asg_health_check_type                      = string
    lt_version                                 = string
    task_defination_family                     = string
    task_requires_compatibilities              = list(string)
    task_network_mode                          = string
    container_memory                           = string
    container_cpu                              = string
    container_ecr_image                        = string
    container_name                             = string
    container_host_port                        = number
    container_port                             = number
    service_name                               = string
    service_desired_count                      = number
    service_launch_type                        = string
    service_deployment_minimum_healthy_percent = number
    service_deployment_maximum_percent         = number
    cluster_name                               = string
    lt_name                                    = string
    instance_name                              = string
    alb_name                                   = string
    storage_type                               = string
    secret_username                            = string
    secret_db_name                             = string
    secret_password                            = string
    key_name                                   = string





  }))
}

variable "key_name" {

}

variable "env" {

}

variable "identifier" {

}

