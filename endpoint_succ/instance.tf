data "aws_ami" "demo_ser" {
  
  filter {
			    name   = "image-id"
			    # values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
				values = ["ami-0453898e98046c639"]
			  }
 
 filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

 owners = ["137112412989"]
}

resource "aws_instance" "Server-1" {
  ami           = data.aws_ami.demo_ser.id
  key_name = aws_key_pair.endpoint.id
  vpc_security_group_ids = [aws_security_group.ni-sg.id]
  subnet_id = aws_subnet.end-sub1.id
  instance_type = "t2.micro"

  tags = {
    Name = "Pub-Server-1"
  }
}

resource "aws_instance" "Server-2" {
  ami           = data.aws_ami.demo_ser.id
  key_name = aws_key_pair.endpoint.id
  vpc_security_group_ids = [aws_security_group.ni-sg.id]
  subnet_id = aws_subnet.end-sub2.id
  instance_type = "t2.micro"

  tags = {
    Name = "Priv-Server-2"
  }
}