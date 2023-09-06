resource "aws_vpc" "B" {
  provider = aws.ohio
  cidr_block           = "35.10.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "VPC-B"
  }
}

resource "aws_subnet" "sub-B" {
  provider = aws.ohio
  vpc_id                  = aws_vpc.B.id
  cidr_block              = "35.10.1.0/25"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"

}

resource "aws_security_group" "sg-B" {
  provider = aws.ohio
  name        = "all_traffic"
  description = "sg for VPC-B"
  vpc_id      = aws_vpc.B.id

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
    Name = "sg-B"
  }
}
