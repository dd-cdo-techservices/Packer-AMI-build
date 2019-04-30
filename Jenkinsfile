pipeline {
  
  agent any  
  
  stages {
    stage('checkout') {
      steps {
        checkout scm
  	    }
    	}
    
 
    stage('Packer version') {
      steps {
        sh '/usr/bin/packer --version'
      }
    }
	
    stage('Image Build') {
      steps {
        sh '/usr/bin/packer build image.json'
      }
    }
   stage('Encrypt Image') {
      steps {
	sh 'image1= aws ec2 describe-images --region ap-south-1 --owners 574515450298 --filters "Name=tag:Name,Values=ubuntu*" --query "Images[*].{ID:ImageId}" --output text'      
        sh 'aws ec2 copy-image  --source-image-id $image1 --source-region ap-south-1 --region ap-south-1 --encrypted  --kms-key-id  arn:aws:kms:ap-south-1:574515450298:key/834f4257-2782-4703-99ec-57f673dc3a6b  --name "Encrypted Ubuntu AMI" '
	cleanWs()
      }
    }
  }
}
