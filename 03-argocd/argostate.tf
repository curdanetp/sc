terraform {
  backend "s3" {
    bucket = "sc-eks-terraform-vpc-state"
    key    = "03-argo/terraform.tfstate"
    region = "us-east-1"    
  }
}