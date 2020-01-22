module "my_iam1" {
  source = "../modules/iam"
  iam_profile_name = "${var.iam_profile_name}"
  iam_name = "${var.iam_name}"
}

resource "aws_launch_configuration" "web-launchconfig" {
  name_prefix          = "web-launchconfig"
  image_id             = "${var.WEB_INSTANCE_AMI}"
  instance_type        = "t2.micro"
  security_groups      = ["${aws_security_group.web-instance.id}"]

  user_data            =  "${file("scripts.sh")}"
  iam_instance_profile = "${module.my_iam1.iam_name}"
  key_name = "${var.key_name}"

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "web-autoscaling" {

  name = "${aws_launch_configuration.web-launchconfig.name}-asg"

  vpc_zone_identifier  = "${data.aws_subnet_ids.selected.ids}"
  launch_configuration = "${aws_launch_configuration.web-launchconfig.name}"
  min_size             = 2
  max_size             = 2
  health_check_grace_period = 300
  health_check_type = "ELB"
  load_balancers = ["${aws_elb.web-elb.name}"]
  force_delete = true

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key = "Name"
    value = "web ec2 instance"
    propagate_at_launch = true
  }
}

