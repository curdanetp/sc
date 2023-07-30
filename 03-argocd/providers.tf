provider "aws" {
  region = "us-east-1"
}

data "aws_eks_cluster" "this" {
  name = data.terraform_remote_state.eks.outputs.eks_cluster_id
}

data "aws_eks_cluster_auth" "this" {    
  name = data.terraform_remote_state.eks.outputs.eks_cluster_id
}

provider "kubernetes" {
  host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
  token                  = data.terraform_remote_state.eks.outputs.aws_eks_cluster_auth_token
  cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.aws_eks_cluster_certificate_authority_data)
}

provider "helm" {
  kubernetes {
  host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
  token                  = data.terraform_remote_state.eks.outputs.aws_eks_cluster_auth_token
    cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.aws_eks_cluster_certificate_authority_data)
  }
}