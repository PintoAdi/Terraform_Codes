resource "aws_lb" "prac_lb" {
  name               = "nlb-lb"
  internal           = false
  load_balancer_type = "network"
  security_groups = [aws_security_group.nat-sg.id]
  enable_deletion_protection = false
  subnets = [aws_subnet.pub-sub.id]
}

resource "aws_lb_target_group" "nlb-tg" {

  health_check {
    protocol = "TCP"
    healthy_threshold = 3
    unhealthy_threshold = 2
    timeout = 5
    interval = 10
    }
  
  name     = "NLB-TG"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.nat-vpc.id
}

resource "aws_lb_target_group_attachment" "att-nlb" {
  count = 3
  target_group_arn = aws_lb_target_group.nlb-tg.arn
  target_id        = aws_instance.priv-serv[count.index].id
  port             = 80
}

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.prac_lb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.nlb-tg.arn
  }
}