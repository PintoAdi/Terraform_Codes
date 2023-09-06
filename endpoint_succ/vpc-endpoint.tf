resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = aws_vpc.vpc-end.id
  service_name = "com.amazonaws.us-east-1.s3"
  depends_on = [ aws_s3_bucket.endpoint-s3 ]
  tags = {
    Environment = "Terra-VPE"
  }
}

resource "aws_vpc_endpoint_route_table_association" "example" {
  route_table_id  = aws_route_table.rt-sub2.id
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
  depends_on = [ aws_vpc_endpoint.s3_endpoint ]
}