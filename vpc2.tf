# VPC 2
resource "aws_vpc" "vpc2" {
  cidr_block           = "192.168.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc2"
  }
}

# Elastic IP
resource "aws_eip" "nat_elastic_ip" {
  vpc = true
  tags = {
    Name = "NAT-gateway-IP"
  }
}

# NGW (nat gateway)
resource "aws_nat_gateway" "ngw2" {
  allocation_id = aws_eip.nat_elastic_ip.id
  subnet_id     = aws_subnet.vpc2_pub_subnet_1.id

  tags = {
    Name = "NAT-gateway"
  }

  depends_on = [aws_internet_gateway.igw2]
}

# IGW (internet gateway)
resource "aws_internet_gateway" "igw2" {
  vpc_id = aws_vpc.vpc2.id
  tags = {
    Name = "vpc2-igw"
  }
}

# Subnet_1 192.168.0.0/24 public
resource "aws_subnet" "vpc2_pub_subnet_1" {
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = "192.168.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "vpc2-pub-subnet-1"
  }
}

# Subnet_2 192.168.1.0/24 private
resource "aws_subnet" "vpc2_prv_subnet_1" {
  vpc_id     = aws_vpc.vpc2.id
  cidr_block = "192.168.1.0/24"
  tags = {
    Name = "vpc2-prv-subnet-1"
  }
}

# VPC 1 default route table
resource "aws_default_route_table" "vpc2_pub_route_table" {
  default_route_table_id = aws_vpc.vpc2.default_route_table_id
  tags = {
    Name = "vpc2-pub-route-table"
  }
}

# VPC 1 custom route table
resource "aws_route_table" "vpc2_prv_route_table" {
  vpc_id = aws_vpc.vpc2.id
  tags = {
    Name = "vpc2-prv-route-table"
  }
}

# Subnet_1/pub_route_table association
resource "aws_route_table_association" "vpc2_pub_route_table_association" {
  route_table_id = aws_default_route_table.vpc2_pub_route_table.id
  subnet_id      = aws_subnet.vpc2_pub_subnet_1.id
}

# Subnet_1/prv_route_table association
resource "aws_route_table_association" "vpc2_prv_route_table_association" {
  route_table_id = aws_route_table.vpc2_prv_route_table.id
  subnet_id      = aws_subnet.vpc2_prv_subnet_1.id
}

# Route to NGW
resource "aws_route" "ngw2_route" {
  route_table_id         = aws_route_table.vpc2_prv_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw2.id
}

# Route to IGW
resource "aws_route" "igw2_route" {
  route_table_id         = aws_default_route_table.vpc2_pub_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw2.id
}

# Route to TGW
resource "aws_route" "vpc2_tgw_route" {
  route_table_id         = aws_route_table.vpc2_prv_route_table.id
  destination_cidr_block = "10.0.0.0/16" # VPC1 address space
  transit_gateway_id     = aws_ec2_transit_gateway.tgw1.id
}
