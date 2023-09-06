resource "aws_route_table_association" "RT-A" {
  subnet_id      = aws_subnet.alb-sub1.id
  route_table_id = aws_route_table.ALB-RT.id
}

resource "aws_route_table_association" "RT-B" {
  subnet_id      = aws_subnet.alb-sub2.id
  route_table_id = aws_route_table.ALB-RT.id
}

resource "aws_route_table_association" "RT-C" {
  subnet_id      = aws_subnet.alb-sub3.id
  route_table_id = aws_route_table.ALB-RT.id
}