# test-cicd
testing webhook

cd aws_pipeline/nodejs
ARTIFACT_WEB=`packer build -machine-readable webec2.json | awk -F, '$0 ~/artifact,0,id/ {print $6}'`
AMI_ID_WEB=`echo $ARTIFACT_WEB | cut -d ':' -f2`
echo 'variable "WEB_INSTANCE_AMI" { default = "'${AMI_ID_WEB}'" }' > nodejs_web.tf
aws s3 cp amivar_web.tf s3://cicd-jenkins-terraform/nodejs_web.tf


d128e6ff7b404be48bb9bbd1641b392d


cd aws_pipeline/nodejs
ARTIFACT_WEB=`/usr/local/bin/packer build -machine-readable webec2.json | awk -F, '$0 ~/artifact,0,id/ {print $6}'`
AMI_ID_WEB=`echo $ARTIFACT_WEB | cut -d ':' -f2`
echo 'variable "WEB_INSTANCE_AMI" { default = "'${AMI_ID_WEB}'" }' > nodejs_web.tf
/usr/local/bin/aws s3 cp nodejs_web.tf s3://cicd-jenkins-terraform/nodejs_web.tf