# Create 3 instance with different folders in html like gmail, drive, and photos.
# Each .sh file represents the above required config.

resource "aws_instance" "Server-1" {
  ami           = data.aws_ami.demo_ser.id
  key_name = aws_key_pair.albkey.id
  vpc_security_group_ids = [aws_security_group.alb-sg.id]
  subnet_id = aws_subnet.alb-sub1.id
  instance_type = "t2.micro"
  user_data = "${file("nginx_install1.sh")}"
  tags = {
    Name = "Pub-Server-1"
  }
}

resource "aws_instance" "Server-2" {
  ami           = data.aws_ami.demo_ser.id
  key_name = aws_key_pair.albkey.id
  vpc_security_group_ids = [aws_security_group.alb-sg.id]
  subnet_id = aws_subnet.alb-sub2.id
  instance_type = "t2.micro"
  user_data = "${file("nginx_install2.sh")}"
  tags = {
    Name = "Pub-Server-2"
  }
}

resource "aws_instance" "Server-3" {
  ami           = data.aws_ami.demo_ser.id
  key_name = aws_key_pair.albkey.id
  vpc_security_group_ids = [aws_security_group.alb-sg.id]
  subnet_id = aws_subnet.alb-sub3.id
  instance_type = "t2.micro"
  user_data = "${file("nginx_install3.sh")}"
  tags = {
    Name = "Pub-Server-3"
  }
}