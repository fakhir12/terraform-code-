

# Internet gateway
resource "aws_internet_gateway" "igw" {
  count  = var.create_igw ? 1 : 0
  vpc_id = aws_vpc.vpc.id 
  tags = {
    Name = "${var.env}-${var.identifier}-${var.region}-IGW"
  }
}

# Public route table
resource "aws_route_table" "public_route_table" {
 
  vpc_id = aws_vpc.vpc.id 
  
  # Default route to forward traffic destined for the internet (0.0.0.0/0)
  # to the internet gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = try(aws_internet_gateway.igw[0].id, null)
  }

  tags = {
    Name = "${var.env}-${var.identifier}-${var.region}-Public-RT"
  }
}

# Private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id  # Fixed reference to VPC

  # Default route that directs traffic to a NAT gateway for outbound internet access
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = try(aws_nat_gateway.nat_gateway[0].id, null) 
  }

  tags = {
    Name = "${var.env}-${var.identifier}-${var.region}-Private-RT"
  }
}

# Route table associations (Fixed Subnet References)
resource "aws_route_table_association" "public_subnet_association" {
  for_each       = aws_subnet.public_subnet_1a
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_association" {
 for_each       = aws_subnet.private_subnet_1a
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_route_table.id
}

# Elastic IP address for the NAT gateway
resource "aws_eip" "eip" {
  domain = "vpc"
  depends_on = [ aws_internet_gateway.igw ] # Fixed dependency
  count      = var.create_igw ? 1 : 0 
}

# NAT gateway (Fixed Subnet Reference)
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = try(aws_eip.eip[0].id, null)
  subnet_id     = aws_subnet.public_subnet_1a[keys(aws_subnet.public_subnet_1a)[0]].id 
  depends_on    = [ aws_internet_gateway.igw ]
   count         = var.create_igw ? 1 : 0
}