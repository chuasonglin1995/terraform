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
    bucket         = "songprojectx-terraform-state"
    region         = "ap-southeast-1"
    key            = "terraform/aws/songprojectx/ap-southeast-1/storage/s3/songprojectx-staging-live"
    dynamodb_table = "songprojectx-terraform-lock"
    kms_key_id     = "arn:aws:kms:ap-southeast-1:052972459506:alias/terraform_state_key"
    profile        = "song_local"
  }
}

provider "aws" {
  profile = "song_local"
  region  = "ap-southeast-1"
}
