#!/bin/bash
# volume setup
#pvcreate ${DEVICE}
#vgcreate data ${DEVICE}
#lvcreate --name volume1 -l 100%FREE data
#mkfs.xfs /dev/data/volume1
#mkdir -p /var/lib/jenkins
#mount /dev/data/volume1 /var/lib/jenkins
#echo '/dev/data/volume1 /var/lib/jenkins xfs defaults 0 0' >> /etc/fstab

# jenkins repository
#curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
#rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
#yum clean all

# install dependencies
#update-java-alternatives --set java-1.8.0-openjdk-amd64
# install jenkins
#yum install -y jenkins
#systemctl start jenkins
#systemctl enable jenkins


# install pip
#wget -q https://bootstrap.pypa.io/get-pip.py
#python3 get-pip.py
#rm -f get-pip.py
# install awscli
#pip install awscli

# install terraform
#wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
#&& unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin \
#&& rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# install packer
#cd /usr/local/bin
#wget -q https://releases.hashicorp.com/packer/0.10.2/packer_0.10.2_linux_amd64.zip
#wget -q https://releases.hashicorp.com/packer/{PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
#&& unzip -o packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin \
#&& rm packer_${PACKER_VERSION}_linux_amd64.zip
# clean up
#rm terraform_0.7.7_linux_amd64.zip
#rm packer_0.10.2_linux_amd64.zip
