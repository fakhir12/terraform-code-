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


resource "aws_secretsmanager_secret" "rds_secret" {
  name = "dev/ecs_/wordpress"
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id = aws_secretsmanager_secret.rds_secret.id


  secret_string = jsonencode({
    rds_username = var.rds_username
    rds_password = random_password.rds_password.result
    rds_db_name  = var.rds_db_name
    key_name     = var.key_name

  })

}


