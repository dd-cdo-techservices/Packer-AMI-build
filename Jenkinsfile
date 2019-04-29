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
        sh 'packer --version'
      }
    }
	
    stage('Image Build') {
      steps {
        sh 'packer build image.json'
	cleanWs()
      }
    }
  }
}
