provider "aws" {
  #version = "1.31.0"
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

terraform {
  backend "s3" {
    bucket = "cicd-jenkins-terraform"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_ami" "centos" {
  owners = ["679593333241"]
 most_recent = true
 filter {
   name   = "name"
   values = ["CentOS Linux 7 x86_64 HVM EBS *"]
 }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "template_file" "jenkins-init" {
  template = "${file("data/jenkins-init.sh")}"
  vars = {
    DEVICE = "${var.instance_device_name}"
    JENKINS_VERSION = "${var.jenkin_version}"
    TERRAFORM_VERSION = "${var.terraform_version}"
  }
}

data "template_cloudinit_config" "cloudinit-jenkins" {

  gzip = false
  base64_encode = false

  part  {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.jenkins-init.rendered}"
  }

}

module "my_vpc" {
  source = "../modules/vpc"
  vpc_cidr = "${var.vpc_cidr}"
  public_subnets = "${var.public_subnets}"
  public_subnets_count = "3"
  aws_availability_zones = "${var.aws_availability_zones}"
}

module "my_iam" {
  source = "../modules/iam"
  iam_profile_name = "${var.iam_profile_name}"
  iam_name = "${var.iam_name}"
}

module "my_sg" {
  source = "../modules/security_group"
  vpc_id = "${module.my_vpc.vpc_ids}"
  name_console = "jenkins-sg"
  vpc_cidr = "${module.my_vpc.vpc_cdir}"
}

module "my_jenkins" {
  source = "../modules/ec2"
  instance_type = "t2.micro"
  public_subnets = "${module.my_vpc.public_subnets}"
  ami_id = "${data.aws_ami.centos.id}"
  node_count = "1"
  key_name = "${var.key_name}"
  iam_role_name = "${module.my_iam.iam_name}"
  root_volume_size = "50"
  node_name = "jenkin"
  aws_availability_zones = ["us-east-1a"]
  source_dest_check = true
  secuity_group_id = ["${module.my_sg.jenkins_sg_id}"]
  user_data = "${data.template_cloudinit_config.cloudinit-jenkins.rendered}"
  }


resource "aws_ebs_volume" "jenkins-data" {
  availability_zone = "us-east-1a"
  size = 20
  type = "gp2"
  tags = {
    Name = "jenkins-data"
  }
}

resource "aws_volume_attachment" "jenkins-data-attachment" {
  count = "1"
  device_name = "${var.instance_device_name}"
  volume_id = "${aws_ebs_volume.jenkins-data.id}"
  instance_id = "${module.my_jenkins.ec2s[count.index]}"
  skip_destroy = false
}
resource "null_resource" "jenkins-ansible" {
  count = "1"
  depends_on = [
    "module.my_jenkins"
  ]
  provisioner "local-exec" {
    command = "sed -i -e '/^jenkin_public_ip/s/:.*$/: ${module.my_jenkins.ec2s_pub_ip[count.index]}/' ../ansible/group_vars/all.yaml"
  }
  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${module.my_jenkins.ec2s[count.index]}  && ansible-playbook -i ../ansible/hosts ../ansible/main.yaml"
  }
}
output "jenkins-ip" {
  value = ["${module.my_jenkins.ec2s_pub_ip}"]
}

output "jenkins-id" {
  value = ["${module.my_jenkins.ec2s}"]
}