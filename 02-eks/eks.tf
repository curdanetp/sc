module "eks" {
    source = "terraform-aws-modules/eks/aws"
    version = "19.15.3"

    cluster_name = data.terraform_remote_state.vpc.outputs.cluster_name
    cluster_version = "1.27"

    subnet_ids=data.terraform_remote_state.vpc.outputs.private_subnets  
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

   /*  # Security Group
    node_security_group_additional_rules  = {
            ingress_allow_access_from_control_plane = {
                    type                          = "ingress"
                    protocol                      = "tcp"
                    from_port                     = 9443
                    to_port                       = 9443
                    source_cluster_security_group = true
                    description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
            }
    }
 */
    manage_aws_auth_configmap = true

    # The following two variables are required to create a cluster with a custom VPC.
    cluster_endpoint_private_access = true
    cluster_endpoint_public_access = true

      
    eks_managed_node_group_defaults = {
        disk_size                  = 20
        min_size                   = 1
        max_size                   = 3
        desired_capacity           = 1
        capacity_type              = "SPOT"
        instance_types             = ["t3.small"]
        ami_type                   = "AL2_x86_64"
        //iam_role_attach_cni_policy = true
    }

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
    tags = {
        Name = data.terraform_remote_state.vpc.outputs.cluster_name
        environment = "dev"
        terraform = "true"
    }    
}
/*
data "aws_iam_policy" "ebs_csi_policy" {
    arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

module "irsa-ebs-csi" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "4.7.0"

  create_role                   = true
  role_name                     = "AmazonEKSTFEBSCSIRole-${data.terraform_remote_state.vpc.outputs.cluster_name}"
  provider_url                  = module.eks.oidc_provider
  role_policy_arns              = [data.aws_iam_policy.ebs_csi_policy.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
}

resource "aws_eks_addon" "ebs-csi" {
  cluster_name             = data.terraform_remote_state.vpc.outputs.cluster_name
  addon_name               = "aws-ebs-csi-driver"
  addon_version            = "v1.5.2-eksbuild.1"
  service_account_role_arn = module.irsa-ebs-csi.iam_role_arn
  tags = {
    "eks_addon" = "ebs-csi"
    "terraform" = "true"
  }
}
*/






