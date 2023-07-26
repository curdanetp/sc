terraform {
  backend "s3" {
    bucket = "sc-eks-terraform-vpc-state"
    key    = "02-eks/terraform.tfstate"
    region = "us-east-1"    
  }
}