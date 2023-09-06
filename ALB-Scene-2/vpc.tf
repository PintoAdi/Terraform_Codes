# Create vpc and respective 3 subnets for 3 instances

resource "aws_vpc" "vpc-alb" {
  cidr_block = "20.15.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  
  tags = {
    Name = "VPC-Demo"
  }
}


resource "aws_subnet" "alb-sub1" {
  vpc_id            = aws_vpc.vpc-alb.id
  cidr_block        = "20.15.10.0/25"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "Subnet-E1"
  }
}

resource "aws_subnet" "alb-sub2" {
  vpc_id            = aws_vpc.vpc-alb.id
  cidr_block        = "20.15.11.0/25"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet-E2"
  }
}

resource "aws_subnet" "alb-sub3" {
  vpc_id            = aws_vpc.vpc-alb.id
  cidr_block        = "20.15.12.0/25"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet-E3"
  }
}

# Create 3 network interface for each subnet

resource "aws_network_interface" "alb-nic-1" {
  subnet_id       = aws_subnet.alb-sub1.id
  private_ips     = ["20.15.10.50"]
  security_groups = [aws_security_group.alb-sg.id]
}

resource "aws_network_interface" "alb-nic-2" {
  subnet_id       = aws_subnet.alb-sub2.id
  private_ips     = ["20.15.11.50"]
  security_groups = [aws_security_group.alb-sg.id]
}

resource "aws_network_interface" "alb-nic-3" {
  subnet_id       = aws_subnet.alb-sub3.id
  private_ips     = ["20.15.12.50"]
  security_groups = [aws_security_group.alb-sg.id]
}