output "kubeconfig_command" {
  value = "aws eks --region us-east-1 update-kubeconfig --name ${module.eks.cluster_name}"
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_identity_oidc_issuer" {
  value = "https://${module.eks.oidc_provider}"
}

output "cluster_identity_oidc_issuer_arn" {
  value = module.eks.oidc_provider_arn
}

output "eks_cluster_version" {
  value = module.eks.cluster_version
}

output "cluster_arn" {
  value = module.eks.cluster_arn
}
