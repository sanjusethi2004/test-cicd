variable "elb_name" {
  default = "kube-api"
}
variable "private_subnets" {
  type = "list"
}
variable "security_grp_id" {
  type = "list"
}
variable "elb_healthy_threshold" {
  default = "2"
}
variable "kube_scheduler_port" {
  default = "8080"
}
variable "elb_unhealthy_threshold" {
  default = "2"
}
variable "elb_timeout" {
  default = "15"
}
variable "elb_interval" {
  default = "30"
}
variable "cross_zone_load_balancing" {
  default = true
}
variable "instance_protocol" {
  default = "tcp"
 }
variable "instance_port" {
  default = "6443"
 }
variable "lb_port" {
  default = "6443"
 }
variable "lb_protocol" {
  default = "tcp"
 }
variable "target" {
  default = "HTTP:8080/healthz"
 }
variable "idle_timeout" {
  default = "400"
}
variable "connection_draining" {
  default = true
}
variable "connection_draining_timeout" {
  default = "400"
}
variable "controller_id" {
  type = "list"
}

