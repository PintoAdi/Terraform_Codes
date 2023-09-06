resource "aws_route_table" "rt-a" {
  provider = aws.virginia
  vpc_id = aws_vpc.A.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gwA.id
  }

  tags = {
    Name = "My_RT-A"
  }
}

resource "aws_route_table_association" "a" {
  provider = aws.virginia
  subnet_id = aws_subnet.sub-A.id
  route_table_id = aws_route_table.rt-a.id
}

resource "aws_route_table" "rt-b" {
  provider = aws.ohio
  vpc_id = aws_vpc.B.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gwB.id
  }

  tags = {
    Name = "My_RT-B"
  }
}

resource "aws_route_table_association" "b" {
  provider = aws.ohio
  subnet_id = aws_subnet.sub-B.id
  route_table_id = aws_route_table.rt-b.id
}

resource "aws_route_table" "rt-c" {
  provider = aws.mumbai
  vpc_id = aws_vpc.C.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gwC.id
  }

  tags = {
    Name = "My_RT-C"
  }
}

resource "aws_route_table_association" "c" {
  provider = aws.mumbai
  subnet_id = aws_subnet.sub-C.id
  route_table_id = aws_route_table.rt-c.id
}