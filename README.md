# Terraform workshop - Transit gateway bridging 2 VPCs

## TLDR;

configure locally AWS with `aws configure`, recomended to use an empty account with admin auth.

`terraform init`

`terraform plan`

`terraform apply`

## Description

VPC1 (10.0.0.0/16) has three public subnets in eu-west-1, each in every az.
Internet traffic is routed to an Internet Gateway.
For each subnet, traffic to (192.168.0.0/16) is routed to a Transit Gateway.

VPC2 (192.168.0.0/16) has two subnets, one private and one public.
Internet traffic for public subnet is routed to an Internet Gateway.
Internet traffic for private subnet is routed to a Nat Gateway.
Private subnet also has traffic to (10.0.0.0/16) routed to the Transit Gateway.

Some ec2 are spawned in different subnets.

it's possible to connect in ssh to some of these instances and check the connectivity. In particular, pinging one of the public ec2 in vpc1 from the private ec2 in vpc2 is possible (and viceversa) while the public vpc machine can't access that network.
