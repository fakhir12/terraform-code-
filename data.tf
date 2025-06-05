data "aws_ssm_parameter" "ubuntu_latest_ami" {
  name = "/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

data "aws_availability_zones" "available" {
  state = "available"
}





# # ################################################################################################
# # ################################    secret manger ##############################################
# # #################################################################################################

resource "random_password" "rds_password" {
  length  = 16
  special = false

}


# resource "aws_secretsmanager_secret" "rds_secret" {
#   name = "dev/ecs_/wordpress"
# }

# resource "aws_secretsmanager_secret_version" "rds_secret_version" {
#   secret_id = aws_secretsmanager_secret.rds_secret.id


#   secret_string = jsonencode({
#     rds_username = var.rds_username
#     rds_password = random_password.rds_password.result
#     rds_db_name  = var.rds_db_name
#     key_name     = var.key_name

#   })

# }
# Try to find existing secret first
data "aws_secretsmanager_secret" "existing_rds_secret" {
  name = "dev/ecs_/wordpress"
}

# Only create if doesn't exist
resource "aws_secretsmanager_secret" "rds_secret" {
  count = length(data.aws_secretsmanager_secret.existing_rds_secret.arn) > 0 ? 0 : 1
  name  = "dev/ecs_/wordpress"
}

locals {
  secret_id = length(data.aws_secretsmanager_secret.existing_rds_secret.arn) > 0 ? data.aws_secretsmanager_secret.existing_rds_secret.id : aws_secretsmanager_secret.rds_secret[0].id
  
  secret_arn = length(data.aws_secretsmanager_secret.existing_rds_secret.arn) > 0 ? data.aws_secretsmanager_secret.existing_rds_secret.arn : aws_secretsmanager_secret.rds_secret[0].arn
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id = local.secret_id
  secret_string = jsonencode({
    rds_username = var.rds_username
    rds_password = random_password.rds_password.result
    rds_db_name  = var.rds_db_name
    key_name     = var.key_name
  })
}