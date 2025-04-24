

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
  for_each            = { for security in var.security_groups : security.egress_protocol => security }
  source              = "./modules/security"
  env                 = each.value.env
  identifier          = each.value.identifier
  region              = each.value.region
  vpc_id              = module.vpc[each.value.env].vpc_id
  cidr_blocks         = each.value.cidr_blocks
  egress_protocol     = each.value.egress_protocol
  ingress_protocol    = each.value.ingress_protocol
  ingress_description = each.value.ingress_description
  egress_description  = each.value.egress_description
  ingress_ports       = each.value.ingress_ports
  egress_ports        = each.value.egress_ports
  public_cidr_blocks  = each.value.public_cidr_blocks
  alb_egress_protocol = each.value.alb_egress_protocol



  depends_on = [module.vpc]

}









module "RDS" {
  for_each             = { for RDS in var.RDS : RDS.storage_type => RDS }
  source               = "./modules/RDS"
  name                 = each.value.name
  private_subnet_ids   = module.vpc[each.value.env].private_subnet_ids
  allocated_storage    = each.value.allocated_storage
  storage_type         = each.value.storage_type
  engine               = each.value.engine
  engine_version       = each.value.engine_version
  instance_class       = each.value.instance_class
  parameter_group_name = each.value.parameter_group_name
  db_name              = each.value.db_name
  username             = each.value.username
  db_password          = each.value.db_password
  db_sg_id             = module.security[each.value.egress_protocol].db_sg_id
  skip_final_snapshot  = each.value.skip_final_snapshot
  env                  = each.value.env
  identifier           = each.value.identifier

}

