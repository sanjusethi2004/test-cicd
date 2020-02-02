# test-cicd
Job 1. Create a jenkins job with git webhook to trigger for Ec2 Packer image creation which will we used in second JOB to create Nodejs web application. 

    parameters:
        1. GitHub Project: 
            project url: https://github.com/sanjusethi2004/test-cicd/
        2. Source Code Management
            select git.
               repository URL: https://github.com/sanjusethi2004/test-cicd.git 
                        (note:credential not required as this is public repo)
        3. Build Triggers.
              select "GitHub hook trigger for GITScm polling"
                   (Note: Make sure you have installed "github integration plugin" in jenkins server)
        4. Build
              select: Execute Shell
                Add below lines.
                    cd aws_pipeline/nodejs
                    ARTIFACT_WEB=`/usr/local/bin/packer build -machine-readable webec2.json | awk -F, '$0 ~/artifact,0,id/ {print $6}'`
                    AMI_ID_WEB=`echo $ARTIFACT_WEB | cut -d ':' -f2`
                    echo 'variable "WEB_INSTANCE_AMI" { default = "'${AMI_ID_WEB}'" }' > nodejs_web.tf
                    /usr/local/bin/aws s3 cp nodejs_web.tf s3://cicd-jenkins-terraform/nodejs_web.tf

Job 2. Create a second jenkins job which will be triggered automatically after above job is success. 

       1. GitHub Project: 
            project url: https://github.com/sanjusethi2004/test-cicd/
       2. Source Code Management
            select git.
               repository URL: https://github.com/sanjusethi2004/test-cicd.git 
                        (note:credential not required as this is public repo)
       3. Build Triggers.
              select  "Build after other projects are built"
                 Projects to watch: "Add above Job Name"
       4. Build
              select: Execute Shell
                Add below lines.
                  set +x
                  cd aws_pipeline/nodejs
                  /usr/local/bin/aws s3 cp s3://cicd-jenkins-terraform/nodejs_web.tf nodejs_web.tf
                  /usr/local/bin/terraform init
                  /usr/local/bin/terraform apply -auto-approve
     test commit 1
