terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.12.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = "ENTER YOUR OWN"
  secret_key = "ENTER YOUR OWN"
}

resource "aws_key_pair" "deployer" {
  key_name   = "alb-key"
  public_key = "ENTER YOUR OWN"
}

# create a new my vpc

resource "aws_vpc" "alb-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "ALB-VPC"
  }
}

#Create a Internet Gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.alb-vpc.id
  
  tags = {
    Name = "ALB-VPC"
  }
}

# Create Route Table

resource "aws_route_table" "ALB-RT" {
  vpc_id = aws_vpc.alb-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "ALB-RT"
  }
}

#Create 3 subnets

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.alb-vpc.id
  cidr_block = "10.0.1.0/25"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "NLB-Subnet-1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.alb-vpc.id
  cidr_block = "10.0.2.0/25"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "NLB-Subnet-2"
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id     = aws_vpc.alb-vpc.id
  cidr_block = "10.0.3.0/25"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "NLB-Subnet-3"
  }
}

#Create a RT association

resource "aws_route_table_association" "RT-A" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.ALB-RT.id
}

resource "aws_route_table_association" "RT-B" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.ALB-RT.id
}

resource "aws_route_table_association" "RT-C" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.ALB-RT.id
}

# Create a Security Group

resource "aws_security_group" "nlb-sg" {
  name        = "allow_tls"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.alb-vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nlb-sg"
  }
}

# Create 3 network interface for each subnet

resource "aws_network_interface" "alb-nic-1" {
  subnet_id       = aws_subnet.subnet1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.nlb-sg.id]
}

resource "aws_network_interface" "alb-nic-2" {
  subnet_id       = aws_subnet.subnet2.id
  private_ips     = ["10.0.2.50"]
  security_groups = [aws_security_group.nlb-sg.id]
}

resource "aws_network_interface" "alb-nic-3" {
  subnet_id       = aws_subnet.subnet3.id
  private_ips     = ["10.0.3.50"]
  security_groups = [aws_security_group.nlb-sg.id]
}

#Create an with 3 count instance in different subnets

resource "aws_instance" "alb_instance" {
    count = 3
    ami = "ami-0453898e98046c639"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.nlb-sg.id]
    subnet_id = element([aws_subnet.subnet1.id, aws_subnet.subnet2.id, aws_subnet.subnet3.id], count.index)
    key_name = aws_key_pair.deployer.id

    user_data = "${file("nginx_install.sh")}"
    
    tags = {
    Name = "Webserver-${count.index + 1}"
    
  }
}


resource "aws_lb" "prac_lb" {
  name               = "prac-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.nlb-sg.id]
  enable_deletion_protection = false
  subnets = [aws_subnet.subnet1.id, aws_subnet.subnet2.id, aws_subnet.subnet3.id]
}

resource "aws_lb_target_group" "alb-tg" {

  health_check {
    path = "/"
    protocol = "HTTP"
    healthy_threshold = 3
    unhealthy_threshold = 2
    timeout = 5
    interval = 10
    }

  name     = "alb-demo-tg"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = aws_vpc.alb-vpc.id
}

resource "aws_lb_target_group_attachment" "test1" {
  count = 3
  target_group_arn = aws_lb_target_group.alb-tg.arn
  target_id        = aws_instance.alb_instance[count.index].id
  port             = 80
}

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.prac_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb-tg.arn
  }
}
