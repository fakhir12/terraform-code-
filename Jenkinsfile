pipeline {
    agent any

    environment {
        AWS_REGION = "us-west-1"
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'github-pat', // 🔁 Replace with your actual GitHub Personal Access Token credentialsId in Jenkins
                    branch: 'main',
                    url: 'https://github.com/fakhir12/terraform-code.git'
            }
        }

        stage('Terraform Destroy') {
            steps {
                withCredentials([
                    string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'),
                    string(credentialsId: 'AWS_SESSION_TOKEN', variable: 'AWS_SESSION_TOKEN') // Optional if not using temporary credentials
                ]) {
                    sh '''
                        terraform init -input=false
                        terraform destroy -auto-approve
                    '''
                }
            }
        }
    }
}
