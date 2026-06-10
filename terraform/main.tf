module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.31.2"   # ✅ VERY STABLE version

  cluster_name    = "poc-eks-cluster"
  cluster_version = "1.27"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]

      desired_size = 2
      max_size     = 2
      min_size     = 1
    }
  }
}
