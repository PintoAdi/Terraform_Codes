/*resource "aws_lb_listener_rule" "path_based_routing_rule1" {
  listener_arn = aws_lb_listener.listner.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg-1.arn
  }
  
  condition {
    field  = "path-pattern"
    values = ["/usr/share/nginx/html/gmail"]
  }
}

resource "aws_lb_listener_rule" "path_based_routing_rule2" {
  listener_arn = aws_lb_listener.listner.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg-2.arn
  }

  condition {
    field  = "path-pattern"
    values = ["/usr/share/nginx/html/drive"]
  }
}

resource "aws_lb_listener_rule" "path_based_routing_rule3" {
  listener_arn = aws_lb_listener.listner.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg-3.arn
  }

  condition {
    field  = "path-pattern"
    values = ["/usr/share/nginx/html/photos"]
  }
}*/