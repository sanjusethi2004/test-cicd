provider "aws" {
  #version = "1.31.0"
  region  = "us-east-1"
  profile = "default"
}
####################VPC###################
resource "aws_vpc" "hdp_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.tenancy}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.vpc_tag_name}"
  }
}
################Public Subnet Object####################################
resource "aws_subnet" "hdp_public_subnet" {
  count                   = "${length(var.public_subnets)}"
  vpc_id                  = "${aws_vpc.hdp_vpc.id}"
  cidr_block              = "${var.public_subnets[count.index]}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_availability_zones[count.index]}"
  #availability_zone       = "${data.aws_availability_zones.available.names[1]}"
  tags = {
    Name = "hdp_public"
  }
}
resource "aws_internet_gateway" "hdp_internet_gateway" {
  vpc_id = "${aws_vpc.hdp_vpc.id}"
  tags = {
    Name = "hdp_igw"
  }
}
resource "aws_route_table" "hdp_public_rt" {
  vpc_id = "${aws_vpc.hdp_vpc.id}"
  tags = {
    Name = "hdp_public_rt"
  }
}
resource "aws_route" "hdp_public_route" {
    route_table_id = "${aws_route_table.hdp_public_rt.id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.hdp_internet_gateway.id}"
}

resource "aws_route_table_association" "hdp_public_assoc" {
  count = "${length(var.public_subnets)}"
  subnet_id      = "${element(aws_subnet.hdp_public_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.hdp_public_rt.id}"
}

#################Private subnet Object############################
#resource "aws_subnet" "hdp_private_subnet" {
#  vpc_id                  = "${aws_vpc.hdp_vpc.id}"
#  cidr_block              = "${var.private_subnets[count.index]}"
#  map_public_ip_on_launch = true
#  availability_zone       = "${var.aws_availability_zones[count.index]}"
#  #availability_zone       = "${data.aws_availability_zones.available.names[1]}"
#  count                   = "${length(var.private_subnets)}"
#  tags {
#    Name = "hdp_private"
#  }
#}
# Allocate Elastic IPs for NAT Gateway
#resource "aws_eip" "public_eip" {
#  vpc      = true
#  count = "${var.disable_nat_gt ? "${length(var.private_subnets)}" : 0}"
#  depends_on = ["aws_internet_gateway.hdp_internet_gateway"]
#}

# Assign NAT Gateway to Public Subnet and Elastic IPs
#resource "aws_nat_gateway" "hdp_private_public" {
#  count = "${var.disable_nat_gt ? "${length(var.private_subnets)}" : 0}"
#  allocation_id = "${element(aws_eip.public_eip.*.id, count.index)}"
#  subnet_id     = "${element(aws_subnet.hdp_public_subnet.*.id, count.index)}"
#  depends_on = ["aws_internet_gateway.hdp_internet_gateway"]
#  tags = {
#    Name = "hdp_private_public"
#  }
#}

# Create Private Subnet Route Tables
#resource "aws_route_table" "private_route_table" {
#    vpc_id = "${aws_vpc.hdp_vpc.id}"
#    count = "${length(var.private_subnets)}"
#  tags {
#        Name = "private_route_table"
#    }
#}
# Create Nat Routes
#resource "aws_route" "private_nat_gt" {
#  count = "${var.disable_nat_gt ? "${length(var.private_subnets)}" : 0}"
#  route_table_id = "${element(aws_route_table.private_route_table.*.id, count.index)}"
#  destination_cidr_block = "0.0.0.0/0"
#  nat_gateway_id = "${element(aws_nat_gateway.hdp_private_public.*.id, count.index)}"
#}

#resource "aws_route_table_association" "hdp_private_assoc" {
#  count = "${length(var.private_subnets)}"
#  subnet_id      = "${element(aws_subnet.hdp_private_subnet.*.id, count.index)}"
#  route_table_id = "${element(aws_route_table.private_route_table.*.id, count.index)}"
#}

