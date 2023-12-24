locals {
  bucket_name = "songprojectx-stg-live"
  default_tags = {
    Owner     = "Chua Song Lin"
    ManagedBy = "terraform"
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${local.bucket_name}",
      "arn:aws:s3:::${local.bucket_name}/*",
    ]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::451622602888:user/songlin",
      ]
    }
    actions = [
      "s3:ListBucket",
      "s3:ListBucketVersions",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectTagging",
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:PutObjectTagging",
      "s3:PutObjectVersionAcl",
      "s3:PutObjectVersionTagging",
      "s3:DeleteObject",
      "s3:DeleteObjectTagging",
      "s3:DeleteObjectVersion",
      "s3:DeleteObjectVersionTagging",
    ]
  }
}

module "s3_bucket" {
  source                   = "terraform-aws-modules/s3-bucket/aws"
  version                  = "3.15.1"
  bucket                   = local.bucket_name
  acl                      = "private"
  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"
  restrict_public_buckets  = true
  ignore_public_acls       = true
  block_public_acls        = true
  block_public_policy      = true
  attach_policy            = true
  policy                   = data.aws_iam_policy_document.this.json
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
  cors_rule = [
    {
      allowed_origins = ["*"], // to add domain names
      allowed_methods = ["PUT", "POST", "DELETE", "GET", "HEAD"],
      allowed_headers = ["*"]
    }
  ]
  tags = local.default_tags
}
