



resource "aws_subnet" "private_subnet_1a" {
  for_each = var.private_subnets

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.key
  map_public_ip_on_launch = each.value.private_subnet_map_public_ip_on_launch
  tags = {
    Name = each.value.name
  }
}


resource "aws_subnet" "public_subnet_1a" {
  for_each = var.public_subnets 

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.key
  map_public_ip_on_launch = each.value.public_subnet_map_public_ip_on_launch
  tags = {
    Name = each.value.name
  }
}


