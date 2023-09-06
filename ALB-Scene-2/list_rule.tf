resource "aws_lb_listener_rule" "ins1_rule" {
  listener_arn = aws_lb_listener.listner_1.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg-1.arn
  }

  condition {
    path_pattern {
      values = ["/usr/share/nginx/html/gmail/*"]
    }
  }
}

resource "aws_lb_listener_rule" "ins2_rule" {
  listener_arn = aws_lb_listener.listner_1.arn
  priority     = 101

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg-2.arn
  }

  condition {
    path_pattern {
      values = ["/usr/share/nginx/html/drive/*"]
    }
  }
}

resource "aws_lb_listener_rule" "ins3_rule" {
  listener_arn = aws_lb_listener.listner_1.arn
  priority     = 102

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg-3.arn
  }

  condition {
    path_pattern {
      values = ["/usr/share/nginx/html/photos/*"]
    }
  }
}