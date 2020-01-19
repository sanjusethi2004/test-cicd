resource "aws_instance" "ec2_create" {
  instance_type = "${var.instance_type}"
  ami           = "${var.ami_id}"
  count         = "${var.node_count}"
  monitoring        = "${var.ec2_monitoring}"
  source_dest_check = "${var.source_dest_check}"
  #key_name = "${aws_key_pair.wp_auth.id}"
  key_name             = "${var.key_name}"
  iam_instance_profile = "${var.iam_role_name}"

  root_block_device {
    volume_size = "${var.root_volume_size}"
    volume_type = "${var.volume_type}"
  }

  subnet_id                   = "${var.public_subnets[count.index]}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  availability_zone           = "${var.aws_availability_zones[count.index]}"
  vpc_security_group_ids      = "${var.secuity_group_id}"

  tags = {
    Name            = "${var.node_name}-${count.index}"
    ansibleNodeType = "${var.node_name}"
    ansibleFilter   = "${var.AnsibleFilter}"
    ansibleNodeName = "${var.node_name}${count.index}"
    }

  volume_tags = {
        Name            = "${var.node_name}-${count.index}"
  }
  user_data = "${var.user_data}"
  #user_data = "${data.template_file.my_setup.rendered}"
}

