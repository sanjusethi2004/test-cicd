variable "vpc_id" {}

data "aws_vpc" "selected" {
  id = "${var.vpc_id}"
}


output "vpc_id" {
  value = "${var.vpc_id}"
}