provider "aws" {
  #version = "1.31.0"
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

terraform {
  backend "s3" {
    bucket = "cicd-jenkins-terraforms"
    key    = "web-node.tfstate"
    region = "us-east-1"
  }
}

data "aws_vpc" "selected" {
  tags = {
    Name = "cicd"
  }
}

data "aws_subnet_ids" "selected" {
  vpc_id = "${data.aws_vpc.selected.id}"
}

resource "aws_elb" "web-elb" {
  name = "web-elb"
  subnets = "${data.aws_subnet_ids.selected.ids}"
  security_groups = ["${aws_security_group.web-elb-sq.id}"]
  listener {
    instance_port = "${var.WEB_PORT}"
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:${var.WEB_PORT}/"
    interval = 30
  }

  cross_zone_load_balancing = true
  connection_draining = true
  connection_draining_timeout = 400
  tags = {
    Name = "web-elb"
  }
}

output "web-elb" {
  value = "${aws_elb.web-elb.dns_name}"
}

output "vpc_id" {
  value = "${data.aws_vpc.selected.id}"
}

output "subnet_cidr_blocks" {
  value = [ "${data.aws_subnet_ids.selected.ids}" ]
}
