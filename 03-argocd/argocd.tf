module "eks-argocd" {
  source  = "lablabs/eks-argocd/aws"
  version = "0.1.3"
  cluster_identity_oidc_issuer     = data.terraform_remote_state.eks.config.outputs.eks_cluster_identity_oidc_issuer
  cluster_identity_oidc_issuer_arn = data.terraform_remote_state.eks.config.outputs.eks_cluster_identity_oidc_issuer_arn

  enabled           = true
  argo_enabled      = true
  argo_helm_enabled = false

  self_managed = true

  helm_release_name = "argocd-kubernetes"
  namespace         = "argocd-kubernetes"

  argo_sync_policy = {
    "automated" : {}
    "syncOptions" = ["CreateNamespace=true"]
  }
}