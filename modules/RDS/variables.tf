variable "db_name" {
  description = "Name of the database"
  type = string
  
}

variable "username" {
  description = "Name of the database user"
  type = string
  
}

variable "db_password" {
  description = "Password of the database user"
  type = string
  
}

variable "name" {
  type = string
}

variable "skip_final_snapshot" {
  
}


variable "private_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  
}

variable "storage_type" {
  
}

variable "engine" {
  
}

variable "engine_version" {
  
}


variable "instance_class" {
  
}

variable "parameter_group_name" {
  
}

variable "db_sg_id" {
  
}

variable "env" {
  
}
variable "identifier" {
  
}