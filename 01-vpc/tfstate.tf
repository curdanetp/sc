terraform {
  backend "s3" {
    bucket = "sc-eks-terraform-vpc-state"
    key    = "01-vpc/terraform.tfstate"
    region = "us-east-1"    
  }
}