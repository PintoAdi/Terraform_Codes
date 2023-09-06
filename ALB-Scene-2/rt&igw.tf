#Create a Internet Gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc-alb.id
  
  tags = {
    Name = "ALB-VPC"
  }
}

# Create Route Table

resource "aws_route_table" "ALB-RT" {
  vpc_id = aws_vpc.vpc-alb.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "ALB-RT"
  }
}


