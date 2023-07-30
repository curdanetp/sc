module "eks-argocd" {
  source  = "lablabs/eks-argocd/aws"
  version = "0.1.3"
  cluster_identity_oidc_issuer     = data.terraform_remote_state.eks.outputs.cluster_identity_oidc_issuer
  cluster_identity_oidc_issuer_arn = data.terraform_remote_state.eks.outputs.cluster_identity_oidc_issuer_arn

  enabled           = true
  argo_enabled      = true
  argo_helm_enabled = true

  self_managed = true

  helm_release_name = "argocd-k8s-helm"
  namespace         = "argocd"
  argo_namespace    = "argocd"
  argo_sync_policy = {
    "automated" : {}
    "syncOptions" = ["CreateNamespace=true"]
  }
}

//depends_on = [module.eks.cluster_id]