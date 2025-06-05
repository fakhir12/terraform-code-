data "aws_ami" "ecs" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }
}

# # ################################################################################################
# # ################################    ecs iam policy ##############################################
# # #################################################################################################








resource "aws_iam_role" "ecs_instance_role" {
   
  name = "${var.env}-${var.identifier}-ecs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_managed_attach" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {

  name = "${var.env}-${var.identifier}-ecs-instance_profile"
  role = aws_iam_role.ecs_instance_role.name
}

resource "aws_iam_role" "ecs_task_execution_role" {

  name = "${var.env}-${var.identifier}-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_managed_attach" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}




resource "aws_iam_policy" "ecs_secrets_access" {
  name = "${var.env}-${var.identifier}-ecs-secrets-access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue",
          "kms:Decrypt"
        ],
        Resource = "*" 
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_secrets_access_task_attach" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_secrets_access.arn
}


# # Data sources (will be empty if resources don't exist)
# data "aws_iam_role" "existing_ecs_instance_role" {
#   count = 1
#   name  = "${var.env}-${var.identifier}-ecs-role"
# }

# data "aws_iam_instance_profile" "existing_ecs_instance_profile" {
#   count = 1
#   name  = "${var.env}-${var.identifier}-ecs-instance_profile"
# }

# data "aws_iam_role" "existing_ecs_task_execution_role" {
#   count = 1
#   name  = "${var.env}-${var.identifier}-ecs-task-execution-role"
# }

# # Resources (only create if data source returns empty)
# resource "aws_iam_role" "ecs_instance_role" {
#   count = length(data.aws_iam_role.existing_ecs_instance_role) == 0 ? 1 : 0
#   name  = "${var.env}-${var.identifier}-ecs-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect    = "Allow",
#       Principal = { Service = "ec2.amazonaws.com" },
#       Action    = "sts:AssumeRole"
#     }]
#   })
# }

# resource "aws_iam_instance_profile" "ecs_instance_profile" {
#   count = length(data.aws_iam_instance_profile.existing_ecs_instance_profile) == 0 ? 1 : 0
#   name  = "${var.env}-${var.identifier}-ecs-instance_profile"
#   role  = local.ecs_instance_role_name
# }

# resource "aws_iam_role" "ecs_task_execution_role" {
#   count = length(data.aws_iam_role.existing_ecs_task_execution_role) == 0 ? 1 : 0
#   name  = "${var.env}-${var.identifier}-ecs-task-execution-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect    = "Allow",
#       Principal = { Service = "ecs-tasks.amazonaws.com" },
#       Action    = "sts:AssumeRole"
#     }]
#   })
# }

# locals {
#   ecs_instance_role_name = try(
#     data.aws_iam_role.existing_ecs_instance_role[0].name,
#     aws_iam_role.ecs_instance_role[0].name,
#     null
#   )

#   ecs_instance_profile_name = try(
#     data.aws_iam_instance_profile.existing_ecs_instance_profile[0].name,
#     aws_iam_instance_profile.ecs_instance_profile[0].name,
#     null
#   )

#   ecs_task_execution_role_name = try(
#     data.aws_iam_role.existing_ecs_task_execution_role[0].name,
#     aws_iam_role.ecs_task_execution_role[0].name,
#     null
#   )

#   ecs_task_execution_role_arn = try(
#     data.aws_iam_role.existing_ecs_task_execution_role[0].arn,
#     aws_iam_role.ecs_task_execution_role[0].arn,
#     null
#   )
# }