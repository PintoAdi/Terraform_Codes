resource "aws_vpc" "A" {
  provider = aws.virginia
  cidr_block           = "10.10.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "VPC-A"
  }
}

resource "aws_subnet" "sub-A" { 
  provider = aws.virginia
  vpc_id                  = aws_vpc.A.id
  cidr_block              = "10.10.1.0/25"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

}

resource "aws_security_group" "sg-A" {
  provider = aws.virginia
  name        = "all_traffic"
  description = "sg for VPC-A"
  vpc_id      = aws_vpc.A.id

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
    Name = "sg-A"
  }
}
