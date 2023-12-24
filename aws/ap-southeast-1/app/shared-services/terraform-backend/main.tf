locals {
  base_name = "songprojectx-terraform"
  default_tags = {
    Owner     = "Chua Song Lin"
    ManagedBy = "terraform"
  }
}

module "s3_bucket" {
  source                  = "terraform-aws-modules/s3-bucket/aws"
  version                 = "3.15.1"
  bucket                  = "${local.base_name}-states"
  restrict_public_buckets = true
  ignore_public_acls      = true
  block_public_acls       = true
  block_public_policy     = true

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  versioning = {
    enabled = true
  }
  tags = local.default_tags
}

resource "aws_dynamodb_table" "this" {
  name           = "${local.base_name}-lock"
  read_capacity  = 7
  write_capacity = 7
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = local.default_tags
  lifecycle {
    prevent_destroy = true
  }
}
