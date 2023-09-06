resource "aws_vpc" "C" {
  provider = aws.mumbai
  cidr_block           = "55.10.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "VPC-C"
  }
}

resource "aws_subnet" "sub-C" {
  provider = aws.mumbai
  vpc_id                  = aws_vpc.C.id
  cidr_block              = "55.10.1.0/25"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"

}

resource "aws_security_group" "sg-C" {
  provider = aws.mumbai
  name        = "all_traffic"
  description = "sg for VPC-B"
  vpc_id      = aws_vpc.C.id

  ingress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-C"
  }
}