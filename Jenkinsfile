pipeline {
    agent any

    environment {
        AWS_REGION = "ap-south-1"
        CLUSTER_NAME = "poc-eks-cluster"
    }

    stages {

        // stage('Clone Repo') {
        //     steps {
        //         git 'https://github.com/rajeevgangaraju/Poc-13.git'
        //     }
        // }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Update Kubeconfig') {
            steps {
                sh """
                aws eks update-kubeconfig \
                --region $AWS_REGION \
                --name $CLUSTER_NAME
                """
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                dir('k8s') {
                    sh 'kubectl apply -f deployment.yaml'
                    sh 'kubectl apply -f service.yaml'
                }
            }
        }

        stage('Verify') {
            steps {
                sh 'kubectl get nodes'
                sh 'kubectl get pods'
                sh 'kubectl get svc'
            }
        }
    }
}
