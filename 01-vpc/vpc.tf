module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  
  # This module official from AWS and Hashicorp, create Groups of subnets
  # , so we need to pass the CIDR blocks for each group
  # and the AZs where we want to create the subnets
  
  name= "${var.cluster_name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets  = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  private_subnets = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]

  # Will create a NAT Gateway in each AZ
  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = true
  #enable_dns_hostnames = true

  # Tags to be added to resources
  public_subnet_tags = {
    Name = "${var.cluster_name}-sn-public"
    "kubernetes.role/elb" = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
  private_subnet_tags = {
    Name = "${var.cluster_name}-sn-private"
    "kubernetes.role/internal-elb" = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
  # Tags for the VPC
  tags = {
    Name = "${var.cluster_name}-vpc"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    terraform = "true"
    environment= "dev"
    cluster_name = var.cluster_name
  }
}