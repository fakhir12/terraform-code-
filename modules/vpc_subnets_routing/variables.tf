

variable "vpc_cidr" {}





variable "region" {}

variable "env" {}

variable "identifier" {}


variable "name" {
    type = string
}
data "aws_availability_zones" "available" {}

# variable "cidr_block" {
  
# }

variable "create_igw" {
  description = "Whether to create an Internet Gateway"
  type        = bool
  default     = true 
}

variable "public_subnet_name_pattern" {
  description = "Naming pattern for public subnets. Use placeholders like {env}, {identifier}, {region}, and {index}."
  type        = string
  default     = "{env}-{identifier}-{region}-Public-Subnet-{index}" # Default pattern
}

variable "private_subnet_name_pattern" {
  description = "Naming pattern for private subnets. Use placeholders like {env}, {identifier}, {region}, and {index}."
  type        = string
  default     = "{env}-{identifier}-{region}-Private-Subnet-{index}" # Default pattern
}

variable "public_subnet_map_public_ip_on_launch" {
    description = "Whether to map public IP addresses to instances in the subnet"
    type        = bool

  
}
variable "private_subnet_map_public_ip_on_launch" {
    description = "Whether to map public IP addresses to instances in the subnet"
    
    type        = bool

  
}



variable "private_subnet_cidr_start" {
  description = "Starting index for private subnet CIDR calculation"
  type        = number
 
}

variable "public_subnet_cidr_start" {
  description = "Starting index for public subnet CIDR calculation"
  type        = number
 
}

variable "subnet_newbits" {
    description = "Number of new bits to add to the subnet CIDR calculation"
  
}

variable "public_subnets" {
  

}
variable "private_subnets" {
  
}