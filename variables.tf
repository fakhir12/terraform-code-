


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

    ingress_description = string
    cidr_blocks         = list(string)
    egress_protocol     = string
    ingress_protocol    = string
    egress_description  = string
    identifier          = string
    region              = string
    env                 = string
    ingress_ports       = list(string)
    egress_ports        = list(string)
    public_cidr_blocks  = list(string)
    alb_egress_protocol = string

  }))

}



# # ################################################################################################
# # ################################     RDS          ##############################################
# # #################################################################################################


variable "RDS" {
  type = list(object({
    name                 = string
    db_name              = string
    username             = string
    db_password          = string
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






# # ################################################################################################
# # ################################     ALB          ##############################################
# # #################################################################################################




variable "ALB" {
  description = "ALB configuration"
  type = list(object({
    alb_name                   = string
    load_balancer_type         = string
    target_group_name          = string
    alb_listener_port          = number
    target_group_protocol      = string
    alb_listener_type          = string
    identifier                 = string
    region                     = string
    env                        = string
    egress_protocol            = string
    enable_deletion_protection = bool
    internal                   = bool
  }))


}




# # ################################################################################################
# # ##########################################  end       ##########################################
# # #################################################################################################





