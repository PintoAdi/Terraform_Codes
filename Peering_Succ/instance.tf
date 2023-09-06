resource "aws_instance" "ins_vpcA" {
  provider = aws.virginia
  ami           = var.vpcA_ami
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.sub-A.id
  vpc_security_group_ids = [aws_security_group.sg-A.id]

  tags = {
    Name = "Instance-VPC-A"
  }
}

resource "aws_instance" "ins_vpcB" {
  provider = aws.ohio
  ami           = var.vpcB_ami
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.sub-B.id
  vpc_security_group_ids = [aws_security_group.sg-B.id]

  tags = {
    Name = "Instance-VPC-B"
  }
}

resource "aws_instance" "ins_vpcC" {
  provider = aws.mumbai
  ami           = var.vpcC_ami
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.sub-C.id
  vpc_security_group_ids = [aws_security_group.sg-C.id]

  tags = {
    Name = "Instance-VPC-C"
  }
}