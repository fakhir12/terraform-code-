pipeline {
    agent any
    environment {
        // AWS_ACCESS_KEY_ID     = credentials('aws-creds')
        // AWS_SECRET_ACCESS_KEY = credentials('aws-creds')
        AWS_ACCESS_KEY_ID     = 'ASIAXEFPMSBJELPDWDUZ'
        AWS_SECRET_ACCESS_KEY = '825qeb9oIPi4DfDKsB0bShoyZ4uVSUSrB9jTOZPa'

        
    }
    stages {
        stage('Checkout Code') {
            steps {
                git(
                    branch: 'main', 
                    url: 'https://github.com/fakhir12/terraform-code-.git'
                )
            }
        }
        
        stage('Initialize Terraform') {
            steps {
                sh 'terraform init'
            }
        }
        
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }
        
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }
    
    post {
        always {
            cleanWs() // Clean workspace after build
        }
    }
}