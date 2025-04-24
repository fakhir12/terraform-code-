output "vpc_id" {
  value = aws_vpc.vpc.id
}



output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.vpc.cidr_block
}
output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public_subnet_1a : subnet.id]
}

output "public_subnet_cidr_blocks" {
  value = [for subnet in aws_subnet.public_subnet_1a : subnet.cidr_block]
}

output "public_subnet_availability_zones" {
  value = [for subnet in aws_subnet.public_subnet_1a : subnet.availability_zone]
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private_subnet_1a : subnet.id]
}

output "private_subnet_cidr_blocks" {
  value = [for subnet in aws_subnet.private_subnet_1a : subnet.cidr_block]
}

output "private_subnet_availability_zones" {
  value = [for subnet in aws_subnet.private_subnet_1a : subnet.availability_zone]
}