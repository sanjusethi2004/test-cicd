resource "aws_elb" "elb" {
  name = "${var.elb_name}-elb"
  instances = "${var.controller_id}"
  subnets  = "${var.private_subnets}"
  security_groups = "${var.security_grp_id}"

  listener {
    instance_port     = "${var.instance_port}"
    instance_protocol = "${var.instance_protocol}"
    lb_port           = "${var.lb_port}"
    lb_protocol       = "${var.lb_protocol}"
  }

  health_check {
    healthy_threshold   = "${var.elb_healthy_threshold}"
    unhealthy_threshold = "${var.elb_unhealthy_threshold}"
    timeout             = "${var.elb_timeout}"
    target              = "HTTP:${var.kube_scheduler_port}/healthz"
    interval            = "${var.elb_interval}"
  }

  cross_zone_load_balancing   = "${var.cross_zone_load_balancing}"
  idle_timeout                = "${var.idle_timeout}"
  connection_draining         = "${var.connection_draining}"
  connection_draining_timeout = "${var.connection_draining_timeout}"

  tags = {
    Name = "${var.elb_name}-elb"
  }
}