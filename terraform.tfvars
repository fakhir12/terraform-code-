


# # # ################################################################################################
# # # ###################################    vpc       ###############################################
# # # #################################################################################################

vpcs = [
  {
    name                                   = "vpc-1"
    vpc_cidr                               = "172.16.0.0/16"
    env                                    = "dev"
    identifier                             = "nginx"
    region                                 = "us-east-1"
    public_subnet_name_pattern             = "{env}-{identifier}-{region}-public_Subnet-{index}"
    private_subnet_name_pattern            = "{env}-{identifier}-{region}-private_Subnet-{index}"
    create_igw                             = true
    private_subnet_map_public_ip_on_launch = false
    public_subnet_map_public_ip_on_launch  = true
    public_subnet_cidr_start               = 0
    private_subnet_cidr_start              = 100
    subnet_newbits                         = 8


  },

]


# # # ################################################################################################
# # # ################################     Security     ##############################################
# # # #################################################################################################




security_groups = [
  {

    cidr_blocks         = ["0.0.0.0/0"]
    alb_egress_protocol = "tcp"
    egress_protocol     = "-1"
    ingress_protocol    = "tcp"
    ingress_description = "Allow SSH access from anywhere"
    egress_description  = "Allow all traffic to go out"
    env                 = "dev"
    identifier          = "nginx"
    region              = "us-east-1"
    key_name            = "sg-1"
    ingress_ports       = [80, 81, 83, 8080]
    egress_ports        = [0]
    public_cidr_blocks  = ["0.0.0.0/0"]




  },
]







# # ################################################################################################
# # ################################     ALB          ##############################################
# # #################################################################################################
ALB = [
  {
    alb_name                   = "fakhir-lb"
    load_balancer_type         = "application"
    target_group_name          = "F-target-group"
    alb_listener_port          = "80"
    target_group_protocol      = "HTTP"
    alb_listener_type          = "forward"
    env                        = "dev"
    identifier                 = "nginx"
    region                     = "us-east-1"
    egress_protocol            = "tcp"
    enable_deletion_protection = false
    internal                   = false

  }
]









# # ################################################################################################
# # ################################     RDS          ##############################################
# # #################################################################################################
RDS = [
  {
    allocated_storage    = 10
    storage_type         = "gp2"
    engine               = "mysql"
    engine_version       = "8.0"
    instance_class       = "db.t3.micro"
    parameter_group_name = "default.mysql8.0"
    db_name              = "wordpress"
    username             = "admin"
    db_password          = "admin123"
    env                  = "dev"
    egress_protocol      = -1
    skip_final_snapshot  = true
    name                 = "db_wp_subnet_group"
    identifier           = "database-fs"


  }
]



# # ################################################################################################
# # ##########################################  end       ##########################################
# # #################################################################################################

    