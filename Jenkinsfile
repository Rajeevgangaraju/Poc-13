pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1'
        CLUSTER_NAME = 'poc-eks-cluster'
    }

    stages {

        stage('Initialize') {
            steps {
                echo "Starting CI/CD Pipeline..."
            }
        }

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

        stage('Configure Kubeconfig') {
            steps {
                sh 'aws eks update-kubeconfig --region $AWS_REGION --name $CLUSTER_NAME'
            }
        }

        stage('Deploy to EKS') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
                sh 'kubectl apply -f service.yaml'
            }
        }

        stage('Verification') {
            steps {
                sh 'kubectl get nodes'
                sh 'kubectl get svc'
            }
        }
    }
}
