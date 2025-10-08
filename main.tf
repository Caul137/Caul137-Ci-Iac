terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.14.1"
    }
  }
  backend s3 {
   bucket = "tf_ci_iac_aws_s3_bucket"
   key = "state/terraform.tfstate"
   region = "us-east-2"
  }
  
}

provider "aws" {

}


resource "aws_s3_bucket" "terraform-state"{
  bucket = "tf_ci_iac_aws_s3_bucket"
  force_destroy = true

  lifecycle {
    prevent_destroy = true
  }
  tags = {
    IAc = "true"
  }
}


resource "aws_s3_bucket_versioning" "terraform-state"{
  bucket = "ci_iac"

  versioning_configuration {
    status = "Enabled"
  }
}