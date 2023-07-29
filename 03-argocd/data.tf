data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "sc-eks-terraform-vpc-state"
    key    = "02-eks/terraform.tfstate"
    region = "us-east-1"   
  }
}