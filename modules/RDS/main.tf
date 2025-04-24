
resource "aws_db_subnet_group" "database_subnet_group" {
    name       = "${var.name}-${var.env}"
    subnet_ids = var.private_subnet_ids
    tags = {
        Name = "Subnet Group"
    }
}

resource "aws_db_instance" "datab_subnet_group" {
    identifier = var.identifier
    allocated_storage    = var.allocated_storage
    storage_type         = var.storage_type
    engine               = var.engine
    engine_version       = var.engine_version  
    instance_class       = var.instance_class 
    db_name              = var.db_name
    username             = var.username
    password             = var.db_password
    parameter_group_name = var.parameter_group_name
    db_subnet_group_name = aws_db_subnet_group.database_subnet_group.name
    skip_final_snapshot  = var.skip_final_snapshot
    vpc_security_group_ids = [var.db_sg_id]
    tags = {
        Name = "DB"
    }
}

