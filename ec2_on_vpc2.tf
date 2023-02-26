
resource "aws_instance" "ec2_1_on_vpc2" {
  ami           = "ami-06e0ce9d3339cb039"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.vpc2_prv_subnet_1.id
  vpc_security_group_ids = [
    aws_security_group.vpc2_allow_ingress_ssh.id,
    aws_security_group.vpc2_allow_ingress_icmp.id,
    aws_security_group.vpc2_allow_egress_all.id
  ]
  key_name = aws_key_pair.mistrio.key_name
  tags = {
    Name = "private-ec2-1-on-vpc2"
  }
}

resource "aws_instance" "ec2_2_on_vpc2" {
  ami           = "ami-06e0ce9d3339cb039"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.vpc2_pub_subnet_1.id
  vpc_security_group_ids = [
    aws_security_group.vpc2_allow_ingress_ssh.id,
    aws_security_group.vpc2_allow_ingress_icmp.id,
    aws_security_group.vpc2_allow_egress_all.id
  ]
  key_name = aws_key_pair.mistrio.key_name
  tags = {
    Name = "public-ec2-2-on-vpc2"
  }
}
