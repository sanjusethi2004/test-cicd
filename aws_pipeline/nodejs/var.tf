variable "aws_region" {
  default = "us-east-1"
}
variable "aws_profile" {
  default = "default"
}

variable "key_name" {
  default = "sanjay"
}

variable "WEB_PORT" {
  default =  "8080"
}

variable "iam_name" {
  default = "Web-iam-role"
}

variable "iam_profile_name" {
  default = "web-profile"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

variable "WEB_INSTANCE_AMI" {
  default = "ami-05d0079b67ad6b0b8"
}