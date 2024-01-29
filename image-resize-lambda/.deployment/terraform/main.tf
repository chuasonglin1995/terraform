locals {
  env              = "staging"
  mode             = "development"
  service_name     = "image-resize"
  region           = "us-west-2"
  filename         = "lambda.zip"
  service_hostname = "https://webhooks-service-prod-dev.tidnex.com"
  acs_hostname     = "https://api-crypto-signatures-prod-dev.ap-southeast-1.tidnex.com"
}


module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "image-resize-lambda"
  description   = "Lambda function for image resizing to thumbnail"
  handler       = "index.lambda_handler"
  runtime       = "python3.11"
  publish       = true

  source_path = "../../src"

  store_on_s3 = false
  s3_bucket   = "songprojectx-stg-live"

  layers = [
    "arn:aws:lambda:ap-southeast-1:451622602888:layer:pillow10-1-0:1",
  ]
}

resource "aws_iam_role" "image-resize-worker" {
  name = "${local.service_name}_lambda-role_-${local.env}-${local.mode}"
  managed_policy_arns = [
    "arn:aws:iam::451622602888:policy/service-role/AWSLambdaBasicExecutionRole-a64f958e-6ffb-4963-8341-90ddf171b13f",
    "arn:aws:iam::451622602888:policy/service-role/AWSLambdaS3ExecutionRole-472d4a35-4bea-485f-a65b-6820734ab512"
  ]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
  inline_policy {
    name = "${local.service_name}_lambda-policy_trident-${local.env}-${local.mode}"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action : "s3:PutObject",
          Effect : "Allow",
          Resource : "arn:aws:s3:::songprojectx-stg-live/*"
        }
      ]
    })
  }
}
