resource "aws_lb_listener" "listner_1" {

    load_balancer_arn = aws_lb.scene-2-lb.arn
    port = 80
    protocol = "HTTP"

    default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg-1.arn

  }
 }


/*resource "aws_lb_listener" "listner_2" {

    load_balancer_arn = aws_lb.scene-2-lb.arn
    port = 80
    protocol = "HTTP"

    default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg-2.arn


  }
 }


resource "aws_lb_listener" "listner_3" {

    load_balancer_arn = aws_lb.scene-2-lb.arn
    port = 80
    protocol = "HTTP"

    default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg-3.arn

  }
 }*/



