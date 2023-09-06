#1 Providers addition and key_pair requirement
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.12.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = "ENTER YOUR OWN"
  secret_key = "ENTER YOUR OWN"
}

resource "aws_key_pair" "deployer" {
  key_name   = "Bastion-key"
  public_key = "ENTER YOUR OWN"
}

#2 Crete a VPC saying NAT-VPC

resource "aws_vpc" "nat-vpc" {
  cidr_block = "172.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  
  tags = {
    Name = "VPC-Demo"
  }
}

#3 Create subnets pub and private

resource "aws_subnet" "pub-sub" {
  vpc_id            = aws_vpc.nat-vpc.id
  cidr_block        = "172.0.10.0/25"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "Subnet-Demo"
  }
}

resource "aws_subnet" "priv-sub" {
  vpc_id            = aws_vpc.nat-vpc.id
  cidr_block        = "172.0.11.0/25"
  map_public_ip_on_launch = false
  availability_zone = "us-east-1a"

  tags = {
    Name = "Subnet-Demo"
  }
}

#4 Create the IGW and attach to VPC

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.nat-vpc.id

  tags = {
    Name = "main"
  }
}


#5 Create RT Pub-RT. Associate the approviate public subnet

resource "aws_route_table" "nat-pub-rt" {
  vpc_id            = aws_vpc.nat-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Nat-pub-rt"
  }
}

resource "aws_route_table_association" "pub-ip" {
  subnet_id = aws_subnet.pub-sub.id
  route_table_id = aws_route_table.nat-pub-rt.id
}


#6 Create seccurity groups with all traffic

resource "aws_security_group" "nat-sg" {
  name        = "nat-sg"
  description = "bastion"
  vpc_id      = aws_vpc.nat-vpc.id


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
    Name = "Nat-SG"
  }
}
#7 Create instance with public subnet

data "aws_ami" "demo_ser" {
  
  filter {
			    name   = "image-id"			    
				values = ["ami-0453898e98046c639"]
			  }
 
 filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

 owners = ["137112412989"]
}

resource "aws_instance" "pub-serv" {
  ami           = data.aws_ami.demo_ser.id
  key_name = aws_key_pair.deployer.id
  vpc_security_group_ids = [aws_security_group.nat-sg.id]
  subnet_id = aws_subnet.pub-sub.id
  instance_type = "t2.micro"
  tags = {
    Name = "Pub-Serv"
  }
}

#8 Create instance with private subnet

resource "aws_instance" "priv-serv" {
  ami           = data.aws_ami.demo_ser.id
  key_name = aws_key_pair.deployer.id
  vpc_security_group_ids = [aws_security_group.nat-sg.id]
  subnet_id = aws_subnet.priv-sub.id
  instance_type = "t2.micro"
  tags = {
    Name = "Priv-Serv"
  }
}
#9 Create another route table name Priv-RT. Add the nat-gw with all ips in the priv-rt

resource "aws_route_table" "nat-priv-rt" {
  vpc_id            = aws_vpc.nat-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "Nat-priv-rt"
  }
}

resource "aws_route_table_association" "priv-ip" {
  subnet_id = aws_subnet.priv-sub.id
  route_table_id = aws_route_table.nat-priv-rt.id
}
#####10 Validate in aws if able to connect to the priv with the public server

#11 Create an elastic ip and associte with the nat-gw

resource "aws_eip" "nat-eip" {
    domain   = "vpc"
}

#12 Create a nat gw with nat-gw and connect that to the public subnet

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.pub-sub.id

  tags = {
    Name = "NAT-GW"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}





####13 validate ping to the priv serv from the public serv 
