terraform {
  required_version = "= v1.3.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    encrypt        = true
    bucket         = "songprojectx-terraform-states"
    region         = "ap-southeast-1"
    key            = "terraform/aws/songprojectx/ap-southeast-1/storage/s3/songprojectx-staging-live"
    dynamodb_table = "songprojectx-terraform-lock"
    kms_key_id     = "arn:aws:kms:ap-southeast-1:451622602888:alias/terraform_state_key"
    profile        = "song_aws"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}
