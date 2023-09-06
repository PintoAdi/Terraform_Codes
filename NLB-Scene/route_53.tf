resource "aws_route53_zone" "primary" {
  name = "mydevtasks.in"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www"
  type    = "A"

  alias {
    name = aws_lb.prac_lb.dns_name
    zone_id = aws_lb.prac_lb.zone_id
    evaluate_target_health = true
  }
}