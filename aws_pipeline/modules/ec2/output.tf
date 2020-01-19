output "ec2s" {
  value = "${aws_instance.ec2_create.*.id}"
}

output "ec2s_pub_ip" {
  value = "${aws_instance.ec2_create.*.public_ip}"
}

output "ec2_pri_ip" {
  value = "${aws_instance.ec2_create.*.private_ip}"
}

output "ec2_pri_dns_name" {
  value = "${aws_instance.ec2_create.*.private_dns}"
}