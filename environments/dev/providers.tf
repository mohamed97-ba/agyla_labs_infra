terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.46.0"
      
    }
  }

}
provider "aws" {
  region = "us-east-1"
  

  default_tags {
    tags = {
      Environment = var.environment
      Name        = "med-serverless-lab"
    }
  }
}


