
# SG allow ingress ssh
resource "aws_security_group" "vpc1_allow_ingress_ssh" {
  name        = "vpc1_allow_ingress_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vpc1.id

  tags = {
    Name = "vpc1-allow-ingress-ssh"
  }
}

# SG role allow ssh
resource "aws_vpc_security_group_ingress_rule" "vpc1_allow_ssh" {
  security_group_id = aws_security_group.vpc1_allow_ingress_ssh.id
  description       = "SSH from anywhere"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

# SG allow ingress ICMP
resource "aws_security_group" "vpc1_allow_ingress_icmp" {
  name        = "vpc1_allow_ingress_icmp"
  description = "Allow ICMP inbound traffic"
  vpc_id      = aws_vpc.vpc1.id

  tags = {
    Name = "vpc1-allow-ingress-icmp"
  }
}

# SG role allow ICMP
resource "aws_vpc_security_group_ingress_rule" "vpc1_allow_icmp" {
  security_group_id = aws_security_group.vpc1_allow_ingress_icmp.id
  description       = "ICMP from anywhere"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8
  to_port           = 0
  ip_protocol       = "icmp"
}

# SG allow egress all
resource "aws_security_group" "vpc1_allow_egress_all" {
  name        = "vpc1_allow_egress_all"
  description = "Allow all outbound traffic"
  vpc_id      = aws_vpc.vpc1.id

  tags = {
    Name = "vpc1-allow-egress-all"
  }
}

# SG role allow all traffic
resource "aws_vpc_security_group_egress_rule" "vpc1_allow_all" {
  security_group_id = aws_security_group.vpc1_allow_egress_all.id
  description       = "allow all outbound traffic"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
