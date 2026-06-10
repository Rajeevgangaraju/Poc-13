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

        // ✅ FORCE CLEAN (Important to fix your errors)
        stage('Force Clean Terraform') {
            steps {
                sh '''
                rm -rf terraform/.terraform
                rm -rf terraform/.terraform.lock.hcl
                rm -rf ~/.terraform.d
                '''
            }
        }

        // ✅ Terraform Init (force correct module + provider)
        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init -upgrade -reconfigure'
                }
            }
        }

        // ✅ Terraform Apply (creates VPC + EKS)
        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Terraform Destroy') {
            steps {
                dir('terraform') {
                    sh 'terraform destroy -auto-approve'
                }
            }
        }

        // ✅ Configure kubectl to connect to EKS
        stage('Configure Kubeconfig') {
            steps {
                sh 'aws eks update-kubeconfig --region $AWS_REGION --name $CLUSTER_NAME'
            }
        }

        // ✅ Deploy application to EKS
        stage('Deploy to EKS') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
                sh 'kubectl apply -f service.yaml'
            }
        }

        // ✅ Verification
        stage('Verification') {
            steps {
                sh 'kubectl get nodes'
                sh 'kubectl get pods'
                sh 'kubectl get svc'
            }
        }
    }
}
