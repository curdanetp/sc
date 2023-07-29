module "eks" {
    source = "terraform-aws-modules/eks/aws"
    version = "19.15.3"

    cluster_name = data.terraform_remote_state.vpc.outputs.cluster_name
    cluster_version = "1.27"

    subnet_ids=data.terraform_remote_state.vpc.outputs.private_subnets  
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

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



