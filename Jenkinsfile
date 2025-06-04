pipeline {
    agent any
    environment {
        // Best practice: Use withCredentials for sensitive data
        AWS_ACCESS_KEY_ID     = credentials('aws-creds')
        AWS_SECRET_ACCESS_KEY = credentials('aws-creds')
        TF_IN_AUTOMATION     = 'true'  // Recommended for CI/CD environments
    }
    
    stages {
        // Single checkout stage is sufficient
        stage('Checkout Code') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: 'main']],
                    extensions: [],
                    userRemoteConfigs: [[
                        url: 'https://github.com/fakhir12/terraform-code-.git',
                        credentialsId: 'github-creds'  // Add if repo is private
                    ]]
                ])
            }
        }
        
        // Consolidated initialization
        stage('Initialize Terraform') {
            steps {
                sh 'terraform init -input=false'  // -input=false prevents hanging
            }
        }
        
        // Planning with output file
        stage('Plan Infrastructure') {
            steps {
                sh 'terraform plan -out=tfplan -input=false'
                archiveArtifacts artifacts: 'tfplan', onlyIfSuccessful: true
            }
        }
        
        // Manual approval gate for production
        stage('Approval') {
            when {
                branch 'main'  // Only require approval for main branch
            }
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    input message: 'Apply Terraform changes?'
                }
            }
        }
        
        // Application using saved plan
        stage('Apply Changes') {
            steps {
                sh 'terraform apply -input=false tfplan'
            }
        }
    }
    
    post {
        always {
            // Clean up sensitive files
            sh 'rm -rf tfplan || true'
            cleanWs()
        }
        success {
            // Add success notifications
            echo 'Terraform deployment completed successfully'
        }
        failure {
            // Add failure notifications
            echo 'Pipeline failed - check logs for details'
        }
    }
}