data "aws_eks_cluster_id" "default" {
  name = data.terraform_remote_state.eks.outputs.eks_cluster_id
}
data "aws_eks_cluster_auth" "default" {
  name = data.terraform_remote_state.eks.outputs.eks_cluster_id
}

data "aws_eks_cluster_auth" "cluster_auth" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}


provider "aws" {
  region = "us-east-1"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  token                  = data.aws_eks_cluster_auth.default.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
}

provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
    token                  = "${data.aws_eks_cluster_auth.cluster_auth.token}"
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  }
}