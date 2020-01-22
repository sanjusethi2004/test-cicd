resource "aws_security_group" "web-instance" {
  vpc_id = "${data.aws_vpc.selected.id}"
  name = "allow-web-ssh"
  description = "security group that allows all egress traffic"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "${var.WEB_PORT}"
    to_port = "${var.WEB_PORT}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "web-instance"
  }
}

resource "aws_security_group" "web-elb-sq" {
  vpc_id = "${data.aws_vpc.selected.id}"
  name = "web-elb"
  description = "security group for load balancer"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "api-elb"
  }
}