#output "private_subnets" {
#  value = "${aws_subnet.hdp_private_subnet.*.id}"
#}
output "public_subnets" {
  value = "${aws_subnet.hdp_public_subnet.*.id}"
}

output "vpc_ids" {
  value = "${aws_vpc.hdp_vpc.id}"
}

output "vpc_cdir" {
  value = "${var.vpc_cidr}"
}

output "public_subnet_count" {
  value = "${var.public_subnets_count}"
}

#output "private_nat_gt" {
#  value = ["${aws_nat_gateway.hdp_private_public.*.id}"]
#}

#output "private_route_tables" {
#  value = [ "${aws_route_table.private_route_table.*.id}" ]
#}

output "public_route_tables" {
  value = [ "${aws_route_table.hdp_public_rt.*.id}" ]
}

output "availability_zones" {
  value = "${var.aws_availability_zones}"
}

#output "private_subnet_id" {
#  value = [ "${aws_subnet.hdp_private_subnet.*.id}" ]
#}

#output "avz" {
#  value = "${data.avz.name}"
#}