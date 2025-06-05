

module "vpc" {
  source   = "./modules/vpc_subnets_routing"
  for_each = { for vpc in var.vpcs : vpc.env => vpc }

  name                                   = "${each.value.env}-${each.value.identifier}-${each.value.region}-${each.value.name}"
  env                                    = each.value.env
  identifier                             = each.value.identifier
  region                                 = each.value.region
  vpc_cidr                               = each.value.vpc_cidr
  public_subnet_name_pattern             = each.value.public_subnet_name_pattern
  private_subnet_name_pattern            = each.value.private_subnet_name_pattern
  create_igw                             = each.value.create_igw
  private_subnet_map_public_ip_on_launch = each.value.private_subnet_map_public_ip_on_launch
  public_subnet_map_public_ip_on_launch  = each.value.public_subnet_map_public_ip_on_launch
  public_subnet_cidr_start               = each.value.public_subnet_cidr_start
  private_subnet_cidr_start              = each.value.private_subnet_cidr_start
  subnet_newbits                         = each.value.subnet_newbits
  private_subnets                        = local.vpc_configs[each.key].private_subnets
  public_subnets                         = local.vpc_configs[each.key].public_subnets

}







module "security" {
  for_each             = { for security in var.security_groups : security.egress_protocol => security }
  source               = "./modules/security"
  env                  = each.value.env
  identifier           = each.value.identifier
  region               = each.value.region
  vpc_id               = module.vpc[each.value.env].vpc_id
  cidr_blocks          = each.value.cidr_blocks
  egress_protocol      = each.value.egress_protocol
  ingress_protocol     = each.value.ingress_protocol
  ingress_description  = each.value.ingress_description
  egress_description   = each.value.egress_description
  ingress_ports        = each.value.ingress_ports
  egress_ports         = each.value.egress_ports
  public_cidr_blocks   = each.value.public_cidr_blocks
  alb_egress_protocol  = each.value.alb_egress_protocol
  alb_ingress_protocol = each.value.alb_ingress_protocol



  depends_on = [module.vpc]

}




# module "ALB" {
#   for_each                         = { for ALB in var.ALB : ALB.alb_name => ALB }
#   source                           = "./modules/ALB"
#   env                              = each.value.env
#   identifier                       = each.value.identifier
#   region                           = each.value.region
#   vpc_id                           = module.vpc[each.value.env].vpc_id
#   alb_sg_id                        = module.security[each.value.alb_egress_protocol].alb_sg_id
#   public_subnet_ids                = module.vpc[each.value.env].public_subnet_ids
#   alb_name                         = each.value.alb_name
#   load_balancer_type               = each.value.load_balancer_type
#   target_group_name                = each.value.target_group_name
#   alb_listener_port                = each.value.alb_listener_port
#   alb_listener_type                = each.value.alb_listener_type
#   target_group_protocol            = each.value.target_group_protocol
#   internal                         = each.value.internal
#   enable_deletion_protection       = each.value.enable_deletion_protection
#   health_check_path                = each.value.health_check_path
#   health_check_protocol            = each.value.health_check_protocol
#   health_check_healthy_threshold   = each.value.health_check_healthy_threshold
#   health_check_unhealthy_threshold = each.value.health_check_unhealthy_threshold
#   health_check_timeout             = each.value.health_check_timeout
#   health_check_interval            = each.value.health_check_interval
#   health_check_matcher             = each.value.health_check_matcher


# }




# module "RDS" {
#   for_each             = { for RDS in var.RDS : RDS.storage_type => RDS }
#   source               = "./modules/RDS"
#   name                 = each.value.name
#   private_subnet_ids   = module.vpc[each.value.env].private_subnet_ids
#   allocated_storage    = each.value.allocated_storage
#   storage_type         = each.value.storage_type
#   engine               = each.value.engine
#   engine_version       = each.value.engine_version
#   instance_class       = each.value.instance_class
#   parameter_group_name = each.value.parameter_group_name
#   rds_username         = local.rds_creds.rds_username
#   rds_password         = local.rds_creds.rds_password
#   rds_db_name          = local.rds_creds.rds_db_name
#   db_sg_id             = module.security[each.value.egress_protocol].db_sg_id
#   skip_final_snapshot  = each.value.skip_final_snapshot
#   env                  = each.value.env
#   identifier           = each.value.identifier

# }


# module "ecs" {
#   for_each = { for ecs in var.ECS : "${ecs.env}-${ecs.identifier}" => ecs }
#   source   = "./modules/ECS"

#   env                                        = each.value.env
#   identifier                                 = each.value.identifier
#   region                                     = each.value.region
#   ecs_instance_type                          = each.value.ecs_instance_type
#   vpc_id                                     = module.vpc[each.value.env].vpc_id
#   wordpress_sg_id                            = module.security[each.value.egress_protocol].wordpress_sg_id
#   rds_endpoint                               = module.RDS[each.value.storage_type].rds_endpoint
#   key_name                                   = each.value.key_name
#   public_subnet_ids                          = module.vpc[each.value.env].public_subnet_ids
#   asg_desired_capacity                       = each.value.asg_desired_capacity
#   asg_max_size                               = each.value.asg_max_size
#   asg_min_size                               = each.value.asg_min_size
#   asg_health_check_type                      = each.value.asg_health_check_type
#   lt_associate_public_ip_address             = each.value.lt_associate_public_ip_address
#   lt_version                                 = each.value.lt_version
#   task_defination_family                     = each.value.task_defination_family
#   task_requires_compatibilities              = each.value.task_requires_compatibilities
#   task_network_mode                          = each.value.task_network_mode
#   container_memory                           = each.value.container_memory
#   container_cpu                              = each.value.container_cpu
#   container_ecr_image                        = each.value.container_ecr_image
#   container_name                             = each.value.container_name
#   container_host_port                        = each.value.container_host_port
#   container_port                             = each.value.container_port
#   service_name                               = each.value.service_name
#   service_desired_count                      = each.value.service_desired_count
#   service_launch_type                        = each.value.service_launch_type
#   service_deployment_minimum_healthy_percent = each.value.service_deployment_minimum_healthy_percent
#   service_deployment_maximum_percent         = each.value.service_deployment_maximum_percent
#   cluster_name                               = each.value.cluster_name
#   lt_name                                    = each.value.lt_name
#   instance_name                              = each.value.instance_name
#   target_group_arn                           = module.ALB[each.value.alb_name].target_group_arn
#   alb_arn                                    = module.ALB[each.value.alb_name].alb_arn
#   rds_secret_arn                             = aws_secretsmanager_secret.rds_secret.arn
#   secret_username                            = each.value.secret_username
#   secret_db_name                             = each.value.secret_db_name
#   secret_password                            = each.value.secret_password
# }
