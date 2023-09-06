resource "aws_vpc" "vpc-end" {
  cidr_block = "20.15.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  
  tags = {
    Name = "VPC-Demo"
  }
}

resource "aws_subnet" "end-sub1" {
  vpc_id            = aws_vpc.vpc-end.id
  cidr_block        = "20.15.10.0/25"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "Subnet-E1"
  }
}

resource "aws_subnet" "end-sub2" {
  vpc_id            = aws_vpc.vpc-end.id
  cidr_block        = "20.15.112.0/25"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Subnet-E2"
  }
}

resource "aws_network_interface" "ni-end" {
  subnet_id   = aws_subnet.end-sub1.id
  private_ips = ["20.15.10.100"]
  security_groups = ["${aws_security_group.ni-sg.id}"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_security_group" "ni-sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc-end.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "end-sg"
  }
}

resource "aws_route_table" "rt-sub1" {
  vpc_id = aws_vpc.vpc-end.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.end-gw.id
  }

  tags = {
    Name = "my_pub_1"
  }
}

resource "aws_route_table_association" "sub1" {
  subnet_id = aws_subnet.end-sub1.id
  route_table_id = aws_route_table.rt-sub1.id
}

resource "aws_route_table" "rt-sub2" {
  vpc_id = aws_vpc.vpc-end.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.end-gw.id
  }

  tags = {
    Name = "my_priv_1"
  }
}

resource "aws_route_table_association" "sub2" {
  subnet_id = aws_subnet.end-sub2.id
  route_table_id = aws_route_table.rt-sub2.id
}

resource "aws_internet_gateway" "end-gw" {
  vpc_id = aws_vpc.vpc-end.id

  tags = {
    Name = "IGW"
  }
}