resource "aws_lb" "scene-2-lb" {
  name               = "Scene-2-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb-sg.id]
  enable_deletion_protection = false
  subnets = [aws_subnet.alb-sub1.id, aws_subnet.alb-sub2.id, aws_subnet.alb-sub3.id]
}

resource "aws_lb_target_group" "alb-tg-1" {

    health_check {
    path = "/usr/share/nginx/html/gmail/"
    protocol = "HTTP"
    healthy_threshold = 3
    unhealthy_threshold = 2
    timeout = 5
    interval = 10
    }

  name     = "alb-tg-1"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = aws_vpc.vpc-alb.id
}

resource "aws_lb_target_group_attachment" "att-tg-1" {
  target_group_arn = aws_lb_target_group.alb-tg-1.arn
  target_id        = aws_instance.Server-1.id
  port             = 80
}

resource "aws_lb_target_group" "alb-tg-2" {

  health_check {
    path = "/usr/share/nginx/html/drive/"
    protocol = "HTTP"
    healthy_threshold = 3
    unhealthy_threshold = 2
    timeout = 5
    interval = 10
    }

  name     = "alb-tg-2"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = aws_vpc.vpc-alb.id
}

resource "aws_lb_target_group_attachment" "att-tg-2" {
  target_group_arn = aws_lb_target_group.alb-tg-2.arn
  target_id        = aws_instance.Server-2.id
  port             = 80
}

resource "aws_lb_target_group" "alb-tg-3" {

  health_check {
    path = "/usr/share/nginx/html/photos/"
    protocol = "HTTP"
    healthy_threshold = 3
    unhealthy_threshold = 2
    timeout = 5
    interval = 10
    }

  name     = "alb-tg-3"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = aws_vpc.vpc-alb.id
}

resource "aws_lb_target_group_attachment" "att-tg-3" {
  count = 3
  target_group_arn = aws_lb_target_group.alb-tg-3.arn
  target_id        = aws_instance.Server-3.id
  port             = 80
}
