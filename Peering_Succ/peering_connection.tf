resource "aws_vpc_peering_connection" "vpc_peer_A_to_B" {
  provider = aws.virginia
  vpc_id      = aws_vpc.A.id
  peer_vpc_id = aws_vpc.B.id
  auto_accept = false
  peer_region = "us-east-2"

  tags = {
    Name = "VPC-A to VPC-B connection request"
  }
}

resource "aws_vpc_peering_connection" "vpc_peer_C_to_A" {
  provider = aws.mumbai
  vpc_id      = aws_vpc.C.id
  peer_vpc_id = aws_vpc.A.id
  auto_accept = false
  peer_region = "us-east-1"

  tags = {
    Name = "VPC-A to VPC-C connection request"
  }
}

resource "aws_vpc_peering_connection" "vpc_peer_B_to_C" {
  provider = aws.ohio
  vpc_id      = aws_vpc.B.id
  peer_vpc_id = aws_vpc.C.id
  auto_accept = false
  peer_region = "ap-south-1"

  tags = {
    Name = "VPC-B to VPC-C connection request"
  }
}