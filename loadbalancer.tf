resource "aws_alb" "alb" {
  name            = "lb-${var.prefix}"
  subnets         = ["${var.aws_subnet_private_b}", "${var.aws_subnet_private_c}"]
  security_groups = ["${data.aws_security_group.public_access.id}"]
  internal        = true

  tags {
    Name    = "lb-${var.prefix}"

  }
}

resource "aws_alb_listener" "alb_listener_https" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = "${data.aws_acm_certificate.ceriticate.arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.alb_target_group.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "listener_rule" {
  depends_on   = ["aws_alb_target_group.alb_target_group"]
  listener_arn = "${aws_alb_listener.alb_listener_https.arn}"
  priority     = "1000"
  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.alb_target_group.id}"
  }
  condition {
    field  = "path-pattern"
    values = ["/"]
  }
}

resource "aws_alb_target_group" "alb_target_group" {
  name     = "tg-${var.prefix}"
  port     = "443"
  protocol = "HTTPS"
  vpc_id   = "${var.aws_vpc}"

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    path                = "/"
    port                = "443"
  }

  tags {
    name = "tg-${var.prefix}"
  }

}

resource "aws_alb_target_group_attachment" "join-lb" {
  target_group_arn = "${aws_alb_target_group.alb_target_group.arn}"
  target_id        = "${aws_instance.rancherserver.id}"
  port             = 443
}



