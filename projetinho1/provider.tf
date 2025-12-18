
terraform {
        backend "s3" {
    bucket = "descomplicando-terraform-sampvas"
    key    = "projetinho1"
    region = "us-west-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region  = "us-west-1"      
}