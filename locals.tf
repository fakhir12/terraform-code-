locals {
  rds_creds = {
    rds_username = var.rds_username
    rds_password = random_password.rds_password.result
    rds_db_name  = var.rds_db_name
    key_name     = var.key_name
  }



  availability_zones = slice(data.aws_availability_zones.available.names, 0, 2)

  vpc_configs = {
    for vpc in var.vpcs : vpc.env => {


      private_subnets = {
        for idx, az in local.availability_zones : az => {
          cidr_block                             = cidrsubnet(vpc.vpc_cidr, vpc.subnet_newbits, vpc.private_subnet_cidr_start + idx)
          private_subnet_map_public_ip_on_launch = false
          name = replace(
            replace(
              replace(
                replace(
                  vpc.private_subnet_name_pattern,
                  "{env}", vpc.env
                ),
                "{identifier}", vpc.identifier
              ),
              "{region}", vpc.region
            ),
            "{index}", idx + 1
          )
        }
      }

      public_subnets = {
        for idx, az in local.availability_zones : az => {
          cidr_block                            = cidrsubnet(vpc.vpc_cidr, vpc.subnet_newbits, vpc.public_subnet_cidr_start + idx)
          public_subnet_map_public_ip_on_launch = true
          name = replace(
            replace(
              replace(
                replace(
                  vpc.public_subnet_name_pattern,
                  "{env}", vpc.env
                ),
                "{identifier}", vpc.identifier
              ),
              "{region}", vpc.region
            ),
            "{index}", idx + 1
          )
        }
      }
    }
  }
}




