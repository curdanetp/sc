module "eks"{
  source       = "terraform-aws-modules/eks/aws"
  version = "19.15.3"
  cluster_name      = data.terraform_remote_state.vpc.outputs.cluster_name
  cluster_version   = "1.27"
  subnet_ids=data.terraform_remote_state.vpc.outputs.private_subnets  
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  eks_managed_node_groups = {
    eks-workers = {
      desired_capacity = 1
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3.small"
      ami_type         = "AL2_x86_64"
      subnets          = data.terraform_remote_state.vpc.outputs.private_subnets
      tags = {
        "Name" = "eks-workers"
      }
    }
  }
  manage_aws_auth_configmap = false
}
