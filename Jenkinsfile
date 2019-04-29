pipeline {
  
  agent any  
  
  stages {
    stage('checkout') {
      steps {
        checkout scm
  	    }
    	}
    
    
    stage('Log Path Setup') {
      steps {
        sh 'PACKER_LOG=1'
	sh 'PACKER_LOG_PATH="imagebuildlog.txt"'
      }
    }
    
    stage('Image Build') {
      steps {
        sh 'packr build image.json'
	cleanWs()
      }
    }
  }
}
