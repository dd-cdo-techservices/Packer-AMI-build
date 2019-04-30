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
	      
        sh 'aws ec2 copy-image  --source-image-id ami-03654474063019092 --source-region ap-south-1 --region ap-south-1 --encrypted  --kms-key-id  arn:aws:kms:us-east-2:014742839986:key/23d0c4df-9811-4111-a4a3-8578334a7b05 --name "Encrypted Ubuntu AMI" '
	cleanWs()
      }
    }
  }
}
