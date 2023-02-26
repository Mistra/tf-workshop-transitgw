# TGW
resource "aws_ec2_transit_gateway" "tgw1" {
  description = "transit gateway 1"
}

# Attachment to VPC1
resource "aws_ec2_transit_gateway_vpc_attachment" "vpc1_attachment" {
  subnet_ids         = [aws_subnet.vpc1_subnet_1.id]
  transit_gateway_id = aws_ec2_transit_gateway.tgw1.id
  vpc_id             = aws_vpc.vpc1.id
}

# Attachment to VPC2
resource "aws_ec2_transit_gateway_vpc_attachment" "vpc2_attachment" {
  subnet_ids         = [aws_subnet.vpc2_prv_subnet_1.id]
  transit_gateway_id = aws_ec2_transit_gateway.tgw1.id
  vpc_id             = aws_vpc.vpc2.id
}

# TGW Route Table
resource "aws_ec2_transit_gateway_route_table" "tgw1_route_table" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw1.id
}

# Route from TGW to VPC1
resource "aws_ec2_transit_gateway_route" "tgw_to_vpc1_route" {
  destination_cidr_block         = "10.0.0.0/16" # VPC1 address space
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpc1_attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.tgw1.association_default_route_table_id
}

# Route from TGW to VPC2
resource "aws_ec2_transit_gateway_route" "tgw_to_vpc2_route" {
  destination_cidr_block         = "192.168.0.0/16" # VPC2 address space
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpc2_attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.tgw1.association_default_route_table_id
}
