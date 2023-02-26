
resource "aws_instance" "ec2_1_on_vpc1" {
  ami           = "ami-06e0ce9d3339cb039"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.vpc1_subnet_1.id
  vpc_security_group_ids = [
    aws_security_group.vpc1_allow_ingress_ssh.id,
    aws_security_group.vpc1_allow_ingress_icmp.id,
    aws_security_group.vpc1_allow_egress_all.id
  ]
  key_name = aws_key_pair.mistrio.key_name
  tags = {
    Name = "public-ec2-1-on-vpc1"
  }
}

resource "aws_instance" "ec2_2_on_vpc1" {
  ami           = "ami-06e0ce9d3339cb039"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.vpc1_subnet_2.id
  vpc_security_group_ids = [
    aws_security_group.vpc1_allow_ingress_ssh.id,
    aws_security_group.vpc1_allow_ingress_icmp.id,
    aws_security_group.vpc1_allow_egress_all.id
  ]
  key_name = aws_key_pair.mistrio.key_name
  tags = {
    Name = "public-ec2-2-on-vpc1"
  }
}
