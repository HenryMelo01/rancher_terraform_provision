resource "aws_route53_record" "rancher-b2b" {
  zone_id = "${data.aws_route53_zone.route53_zone.id}"
  name    = "${var.prefix}"
  type    = "A"
  depends_on = ["aws_alb.alb"]
  alias {
    name                   = "${aws_alb.alb.dns_name}"
    zone_id                = "${aws_alb.alb.zone_id}"
    evaluate_target_health = true
  }
}