





resource "aws_security_group" "wordpress_sg" {
    vpc_id = var.vpc_id
    dynamic "ingress" {
       for_each = var.ingress_ports
       iterator = port
       content {
        description = var.alb_ingress_protocol
        from_port = port.value
        to_port = port.value
        protocol = var.ingress_protocol
        cidr_blocks = var.public_cidr_blocks
       
         
       } 
    }

    
    
    dynamic "egress" {
        for_each = var.egress_ports
        iterator = port
        content {
        description = var.egress_description
        from_port = port.value
        to_port = port.value
        protocol = var.egress_protocol
        cidr_blocks = var.cidr_blocks
        
     }
    }
    tags = {
    Name = "${var.env}-wordpress-ecs-sg"
  }
}
resource "aws_security_group" "db_sg" {
    vpc_id = var.vpc_id
    dynamic "ingress" {
       for_each = [3306]
       iterator = port
       content {
        description = var.ingress_description
        from_port = port.value
        to_port = port.value
        protocol = var.alb_ingress_protocol
        security_groups = [aws_security_group.wordpress_sg.id]
       
         
       } 
    }
    dynamic "egress" {
        for_each = [0]
        iterator = port
        content {
        description = var.egress_description
        from_port = port.value
        to_port = port.value
        protocol = var.alb_egress_protocol
        security_groups = [aws_security_group.wordpress_sg.id]
        
        
     }
    }
     tags = {
    Name = "${var.env}-rds-ecs-sg"
  }
}



resource "aws_security_group" "alb_sg" {
    vpc_id = var.vpc_id
    dynamic "ingress" {
       for_each = [80]
       iterator = port
       content {
        description = var.ingress_description
        from_port = port.value
        to_port = port.value
        protocol = var.alb_ingress_protocol
        cidr_blocks = var.cidr_blocks
         
       } 
    }
    dynamic "egress" {
        for_each = [0]
        iterator = port
        content {
        description = var.egress_description
        from_port = port.value
        to_port = port.value
        protocol = var.egress_protocol
        cidr_blocks = var.cidr_blocks
       
       
        
     }
    }
    tags = {
    Name = "${var.env}-alb-ecs-sg"
  }
}