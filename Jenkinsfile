// pipeline {
//     agent any

//     environment {
//         AWS_REGION = "us-west-1"
//     }

//     stages {
//         stage('Checkout') {
//             steps {
//                 git branch: 'main', 
//                     url: 'https://github.com/fakhir12/terraform-code-.git'
//             }
//         }

//         stage('Terraform Init') {
//             steps {
//                 withCredentials([
//                     string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
//                     string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'),
//                     string(credentialsId: 'AWS_SESSION_TOKEN', variable: 'AWS_SESSION_TOKEN')
//                 ]) {
//                     sh 'terraform init -input=false'
//                 }
//             }
//         }

//         stage('Terraform Plan') {
//             steps {
//                 withCredentials([
//                     string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
//                     string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'),
//                     string(credentialsId: 'AWS_SESSION_TOKEN', variable: 'AWS_SESSION_TOKEN')
//                 ]) {
//                     sh 'terraform plan -out=tfplan'
//                 }
//             }
//         }

//         stage('Terraform Apply') {
//             steps {
//                 withCredentials([
//                     string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
//                     string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'),
//                     string(credentialsId: 'AWS_SESSION_TOKEN', variable: 'AWS_SESSION_TOKEN')
//                 ]) {
//                     sh 'terraform apply -auto-approve tfplan'
//                 }
//             }
//         }
//     }
// }
pipeline {
    agent any

    environment {
        AWS_REGION = "us-west-1"
    }

    stages {
        steps {
        git credentialsId: 'github-pat',
            branch: 'main', 
            url: 'https://github.com/fakhir12/terraform-code.git'
    }
        }

        stage('Terraform Destroy') {
            steps {
                withCredentials([
                    string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'),
                    string(credentialsId: 'AWS_SESSION_TOKEN', variable: 'AWS_SESSION_TOKEN')
                ]) {
                    sh '''
                        terraform init -input=false
                        terraform destroy -auto-approve
                    '''
                }
            }
        }

        // Uncomment the below stages if needed for plan/apply workflow

        // stage('Terraform Plan') {
        //     steps {
        //         withCredentials([
        //             string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
        //             string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'),
        //             string(credentialsId: 'AWS_SESSION_TOKEN', variable: 'AWS_SESSION_TOKEN')
        //         ]) {
        //             sh '''
        //                 terraform init -input=false
        //                 terraform plan -out=tfplan
        //             '''
        //         }
        //     }
        // }

        // stage('Terraform Apply') {
        //     steps {
        //         withCredentials([
        //             string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
        //             string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'),
        //             string(credentialsId: 'AWS_SESSION_TOKEN', variable: 'AWS_SESSION_TOKEN')
        //         ]) {
        //             sh 'terraform apply -auto-approve tfplan'
        //         }
        //     }
        // }
    }
}
