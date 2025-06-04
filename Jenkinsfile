pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-creds')  // Uses Jenkins credentials
        AWS_SECRET_ACCESS_KEY = credentials('aws-creds')
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/fakhir12/terraform-code-.git'
            }
        }
        stage('gitpull') {
            steps {
                sh 'git pull origin main'
            }
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Init') {
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
}