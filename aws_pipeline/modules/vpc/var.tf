variable "vpc_cidr" {
  default = "10.0.1.0/24"
}
variable "vpc_tag_name" {
  default = "cicd"
}
variable "tenancy" {
  default = "default"
}

#variable "tenancy" {}

variable "aws_availability_zones" {
  type = "list"
  default = ["us-east-1a", "us-east-1b", "us-east-1c" ]
}

#data "avz" "name" {}

variable "public_subnets" {
  type = "list"
  default = ["10.0.1.0/27", "10.0.1.32/27", "10.0.1.64/27" ]

}
#variable "disable_nat_gt" {
#  default= "1"
#}

#variable "private_subnets_count" {
#  default = "3"
#}

variable "public_subnets_count" {
  default = "3"
}

