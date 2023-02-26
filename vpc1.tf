# VPC 1
resource "aws_vpc" "vpc1" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc1"
  }
}

# IGW (internet gateway)
resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "vpc1-igw"
  }
}

# Subnet_1 10.0.0.0/24
resource "aws_subnet" "vpc1_subnet_1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-1a"
  tags = {
    Name = "vpc1-subnet-1"
  }
}

# Subnet_2 10.0.1.0/24
resource "aws_subnet" "vpc1_subnet_2" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-1b"
  tags = {
    Name = "vpc1-subnet-2"
  }
}

# Subnet_3 10.0.2.0/24
resource "aws_subnet" "vpc1_subnet_3" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "vpc1-subnet-3"
  }
}

# VPC 1 default route table
resource "aws_default_route_table" "vpc1_route_table" {
  default_route_table_id = aws_vpc.vpc1.default_route_table_id
  tags = {
    Name = "vpc1-route-table"
  }
}

# Subnet_1/route_table association
resource "aws_route_table_association" "vpc1_sub1_route_table_association" {
  route_table_id = aws_default_route_table.vpc1_route_table.id
  subnet_id      = aws_subnet.vpc1_subnet_1.id
}

# Subnet_2/route_table association
resource "aws_route_table_association" "vpc1_sub2_route_table_association" {
  route_table_id = aws_default_route_table.vpc1_route_table.id
  subnet_id      = aws_subnet.vpc1_subnet_2.id
}

# Subnet_3/route_table association
resource "aws_route_table_association" "vpc1_sub3_route_table_association" {
  route_table_id = aws_default_route_table.vpc1_route_table.id
  subnet_id      = aws_subnet.vpc1_subnet_3.id
}

# Route to IGW
resource "aws_route" "igw1_route" {
  route_table_id         = aws_default_route_table.vpc1_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw1.id
}

# Route to TGW
resource "aws_route" "vpc1_tgw_route" {
  route_table_id         = aws_default_route_table.vpc1_route_table.id
  destination_cidr_block = "192.168.0.0/16" # VPC2 address space
  transit_gateway_id     = aws_ec2_transit_gateway.tgw1.id
}
