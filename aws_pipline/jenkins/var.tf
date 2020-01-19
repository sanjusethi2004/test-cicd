variable "aws_region" {
  default = "us-east-1"
}
variable "aws_profile" {
  default = "default"
}
variable "vpc_cidr" {
  default = "10.0.1.0/24"
}
variable "aws_availability_zones" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c" ]
}
variable "destination_cidr_block" {
  default = "0.0.0.0/0"
}
variable "cidr_block" {
  default = "0.0.0.0/0"
}
variable "public_subnets" {
  default = ["10.0.1.0/27", "10.0.1.32/27", "10.0.1.64/27" ]
}

variable "iam_name" {
  default = "Jenkins-iam-s3-role"
}
variable "iam_profile_name" {
  default = "jenkin-profile"
}
variable "key_name" {
  default = "sanjay"
}

variable "instance_device_name" {
  default = "/dev/xvdh"
}

variable "terraform_version" {
  default = "v0.12.9"
}
variable "jenkin_version" {
  default = "2.121.2"
}