terraform {
  backend "s3" {
    bucket  = "terraform-remote-state-med"
    key     = "tf-serverless-state"
    region  = "us-east-1"
    encrypt = true
  }
}