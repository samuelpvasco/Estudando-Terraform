
terraform {
        backend "s3" {
    bucket = "descomplicando-terraform-sampvas"
    key    = "aula2-backend"
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