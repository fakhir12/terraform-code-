


# # # ################################################################################################
# # # ###################################    vpc       ###############################################
# # # #################################################################################################

vpcs = [
  {
    name                                   = "vpc"
    vpc_cidr                               = "172.16.0.0/16"
    env                                    = "dev"
    identifier                             = "nginx"
    region                                 = "us-west-1"
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

    cidr_blocks          = ["0.0.0.0/0"]
    alb_egress_protocol  = "tcp"
    alb_ingress_protocol = "tcp"
    egress_protocol      = -1
    ingress_protocol     = -1
    ingress_description  = "Allow SSH access from anywhere"
    egress_description   = "Allow all traffic to go out"
    env                  = "dev"
    identifier           = "nginx"
    region               = "us-west-1"
    key_name             = "sg-1"
    ingress_ports        = [0]
    egress_ports         = [0]
    public_cidr_blocks   = ["0.0.0.0/0"]




  },
]







# # ################################################################################################
# # ################################     ALB          ##############################################
# # #################################################################################################
ALB = [
  {
    alb_name                         = "fakhir-lb"
    load_balancer_type               = "application"
    target_group_name                = "F-target-group"
    alb_listener_port                = "80"
    target_group_protocol            = "HTTP"
    alb_listener_type                = "forward"
    env                              = "dev"
    identifier                       = "nginx"
    region                           = "us-west-1"
    alb_egress_protocol              = -1
    enable_deletion_protection       = false
    internal                         = false
    health_check_path                = "/wp-admin/install.php"
    health_check_protocol            = "HTTP"
    health_check_healthy_threshold   = 5
    health_check_unhealthy_threshold = 2
    health_check_timeout             = 5
    health_check_interval            = 30
    health_check_matcher             = "200"

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
    env                  = "dev"
    egress_protocol      = -1
    skip_final_snapshot  = true
    name                 = "db_wp_subnet_group"
    identifier           = "database-fs"


  }
]


# # ################################################################################################
# # ################################     ecs          ##############################################
# # #################################################################################################





ECS = [
  {
    env                                        = "dev"
    identifier                                 = "nginx"
    region                                     = "us-west-1"
    ecs_instance_type                          = "t3.large"
    egress_protocol                            = -1
    asg_desired_capacity                       = 1
    asg_max_size                               = 2
    asg_min_size                               = 1
    asg_health_check_type                      = "EC2"
    lt_associate_public_ip_address             = true
    lt_version                                 = "$Latest"
    task_defination_family                     = "wordpress-task"
    task_requires_compatibilities              = ["EC2"]
    task_network_mode                          = "bridge"
    container_memory                           = "512"
    container_cpu                              = "256"
    container_ecr_image                        = "wordpress:latest"
    container_name                             = "wordpress"
    container_host_port                        = 8083
    container_port                             = 80
    service_name                               = "wordpress-service"
    service_desired_count                      = 1
    service_launch_type                        = "EC2"
    service_deployment_minimum_healthy_percent = 50
    service_deployment_maximum_percent         = 200
    cluster_name                               = "ecs-cluster"
    lt_name                                    = "ecs-lt"
    instance_name                              = "ecs-instance"
    alb_name                                   = "fakhir-lb"
    storage_type                               = "gp2"
    secret_username                            = "rds_username"
    secret_db_name                             = "rds_db_name"
    secret_password                            = "rds_password"
    key_name                                   = "Fakhir1"






  },


]

key_name     = "Fakhir1"
rds_db_name  = "wordpress"
rds_username = "admin"
env          = "dev"
identifier   = "nginx"


