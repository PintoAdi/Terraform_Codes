resource "aws_vpc_peering_connection_accepter" "peer_accept_B_A" {
  provider = aws.ohio
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_A_to_B.id
  auto_accept = true
  tags = {
    Name = "VPC-A to VPC-B connection accept"
  }
}

resource "aws_vpc_peering_connection_accepter" "peer_accept_A_C" {
  provider = aws.virginia
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_C_to_A.id
  auto_accept = true
  tags = {
    Name = "VPC-C to VPC-A connection accept"
  }
}

resource "aws_vpc_peering_connection_accepter" "peer_accept_C_B" {
  provider = aws.mumbai
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_B_to_C.id
  auto_accept = true
  tags = {
    Name = "VPC-C to VPC-B connection accept"
  }
}