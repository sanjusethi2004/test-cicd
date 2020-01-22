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
  default =  "3000"
}

variable "iam_name" {
  default = "Web-iam-role"
}

variable "iam_profile_name" {
  default = "web-nodejs"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
