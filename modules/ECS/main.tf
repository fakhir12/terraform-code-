data "aws_secretsmanager_secret_version" "rds_secret" {
  secret_id = var.rds_secret_arn
}
resource "aws_ecs_cluster" "wordpress" {
  name = "${var.env}-${var.identifier}-${var.cluster_name}"
}


resource "aws_launch_template" "ecs_launch_template" {
  name          = "${var.env}-${var.identifier}-${var.lt_name}"
  image_id      = data.aws_ami.ecs.id
  instance_type = var.ecs_instance_type
  key_name      = var.key_name 

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_instance_profile.name
    # name = local.ecs_instance_profile_name
  }

  network_interfaces {
    associate_public_ip_address = var.lt_associate_public_ip_address
    device_index                = 0
    security_groups             = [var.wordpress_sg_id]
  }

  user_data = base64encode(<<EOF
  #!/bin/bash
  echo ECS_CLUSTER=${aws_ecs_cluster.wordpress.name} >> /etc/ecs/ecs.config
  EOF
  )
}


resource "aws_autoscaling_group" "ecs_asg" {
  desired_capacity     = var.asg_desired_capacity
  max_size             = var.asg_max_size
  min_size             = var.asg_min_size
  vpc_zone_identifier  = var.public_subnet_ids
  target_group_arns    = []
  health_check_type    = var.asg_health_check_type

  launch_template {
    id      = aws_launch_template.ecs_launch_template.id
    version = var.lt_version
  }

  tag {
    key                 = "Name"
    value               = "${var.env}-${var.identifier}-${var.instance_name}"
    propagate_at_launch = true
  }
}




resource "aws_ecs_task_definition" "wordpress" {
  family                   = "${var.env}-${var.identifier}-${var.task_defination_family }"
  requires_compatibilities = var.task_requires_compatibilities
  network_mode             = var.task_network_mode
  cpu                      = var.container_cpu
  memory                   = var.container_memory  
 execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
task_role_arn      = aws_iam_role.ecs_task_execution_role.arn
  # execution_role_arn = local.ecs_task_execution_role_arn
  # task_role_arn      = local.ecs_task_execution_role_arn




  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.container_ecr_image
      essential = true
      portMappings = [{
        containerPort = var.container_port
        hostPort      = var.container_host_port
      }]
      environment = [
        {
          name  = "WORDPRESS_DB_HOST"
       
        value = var.rds_endpoint
        }
      ]
      secrets = [
        {
          name      = "WORDPRESS_DB_USER"
          valueFrom = "${var.rds_secret_arn}:${var.secret_username}::"
        },
        {
          name      = "WORDPRESS_DB_PASSWORD"
          valueFrom = "${var.rds_secret_arn}:${var.secret_password}::"
        },
        {
          name      = "WORDPRESS_DB_NAME"
          valueFrom = "${var.rds_secret_arn}:${var.secret_db_name}::"
        }
    ]
    }
  ])
}


resource "aws_ecs_service" "wordpress_service" {
  name            = "${var.env}-${var.identifier}-${var.service_name}"
  cluster         = aws_ecs_cluster.wordpress.id
  task_definition = aws_ecs_task_definition.wordpress.arn
  desired_count   = var.service_desired_count
  launch_type     = var.service_launch_type

  deployment_minimum_healthy_percent = var.service_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.service_deployment_maximum_percent 

  depends_on = [aws_autoscaling_group.ecs_asg]
  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}
