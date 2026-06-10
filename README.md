# Poc-13
# Jenkins + Terraform + EKS POC

## Overview
This project demonstrates an end-to-end CI/CD pipeline using:
- Jenkins (CI/CD)
- Terraform (Infrastructure as Code)
- AWS EKS (Kubernetes)
- Nginx Application Deployment

## Flow
1. Jenkins triggers pipeline
2. Terraform provisions VPC and EKS cluster
3. Jenkins configures kubectl
4. Kubernetes manifests are deployed
5. Application exposed via LoadBalancer

## Tools Used
- Jenkins
- Terraform
- AWS (EKS, VPC)
- Kubernetes (kubectl)

## Outcome
Nginx application deployed on AWS EKS and accessed via LoadBalancer URL.
