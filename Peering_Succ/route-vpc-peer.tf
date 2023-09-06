resource "aws_route" "vpcA_to_vpcB" {
  provider = aws.virginia
  route_table_id            = aws_route_table.rt-a.id
  destination_cidr_block    = aws_vpc.B.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_A_to_B.id
  depends_on                = [aws_route_table.rt-a]
}

resource "aws_route" "vpcB_to_vpcA" {
  provider = aws.ohio
  route_table_id            = aws_route_table.rt-b.id
  destination_cidr_block    = aws_vpc.A.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_A_to_B.id
  depends_on                = [aws_route_table.rt-b]
}

resource "aws_route" "vpcA_to_vpcC" {
  provider = aws.virginia
  route_table_id = aws_route_table.rt-a.id
  destination_cidr_block    = aws_vpc.C.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_C_to_A.id
  depends_on                = [aws_route_table.rt-a]
}

resource "aws_route" "vpcC_to_vpcA" {
  provider = aws.mumbai
  route_table_id = aws_route_table.rt-c.id
  destination_cidr_block    = aws_vpc.A.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_C_to_A.id
  depends_on                = [aws_route_table.rt-c]
}

resource "aws_route" "vpcB_to_vpcC" {
  provider = aws.ohio
  route_table_id = aws_route_table.rt-b.id
  destination_cidr_block    = aws_vpc.C.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_B_to_C.id
  depends_on                = [aws_route_table.rt-c]
}

resource "aws_route" "vpcC_to_vpcB" {
  provider = aws.mumbai
  route_table_id = aws_route_table.rt-c.id
  destination_cidr_block    = aws_vpc.B.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_C_to_A.id
  depends_on                = [aws_route_table.rt-c]
}

