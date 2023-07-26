/*
output "load_balancer_controller_role_arn" {
  value = aws_iam_role.load_balancer_controller.arn
}
*/
output "cluster_id" {
  value = module.eks.cluster_id
}
output "kubeconfig_command" {
  value = "aws eks --region us-east-1 update-kubeconfig --name ${module.eks.cluster_name}"
}
