pipeline {
    agent any

    environment {
        AWS_REGION = "us-east-1"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/fakhir12/terraform-code-.git'
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([
                    string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secrets-key', variable: 'AWS_SECRET_ACCESS_KEY'),
                    string(credentialsId: 'token', variable: 'AWS_SESSION_TOKEN')
                ]) {
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([
                    string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secrets-key', variable: 'AWS_SECRET_ACCESS_KEY'),
                    string(credentialsId: 'token', variable: 'AWS_SESSION_TOKEN')
                ]) {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([
                    string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secrets-key', variable: 'AWS_SECRET_ACCESS_KEY'),
                    string(credentialsId: 'token', variable: 'AWS_SESSION_TOKEN')
                ]) {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }
}
