resource "aws_lb" "application_load_balancer" {
    name            = var.alb_name
    internal        = var.internal 
    load_balancer_type = var.load_balancer_type
    security_groups = [var.alb_sg_id]
    subnets         = var.public_subnet_ids
    enable_deletion_protection = var.enable_deletion_protection
   
}

resource "aws_lb_target_group" "target_group" {
    name     = var.target_group_name
    port     = var.alb_listener_port
    protocol = var.target_group_protocol
    vpc_id   = var.vpc_id
}



resource "aws_lb_listener" "alb_listener" {
    load_balancer_arn = aws_lb.application_load_balancer.arn
    port              = var.alb_listener_port
    protocol          = var.target_group_protocol

    default_action {
        type             = var.alb_listener_type
        target_group_arn = aws_lb_target_group.target_group.arn
    }
}