# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "S3TriggerImageResizeRole"
resource "aws_iam_role" "this" {
  assume_role_policy    = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"lambda.amazonaws.com\"}}],\"Version\":\"2012-10-17\"}"
  description           = null
  force_detach_policies = false
  managed_policy_arns   = ["arn:aws:iam::451622602888:policy/service-role/AWSLambdaBasicExecutionRole-a64f958e-6ffb-4963-8341-90ddf171b13f", "arn:aws:iam::451622602888:policy/service-role/AWSLambdaS3ExecutionRole-472d4a35-4bea-485f-a65b-6820734ab512"]
  max_session_duration  = 3600
  name                  = "S3TriggerImageResizeRole"
  name_prefix           = null
  path                  = "/service-role/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
  inline_policy {
    name   = "AllowUploadToS3SongProjectx"
    policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Action\":\"s3:PutObject\",\"Effect\":\"Allow\",\"Resource\":\"arn:aws:s3:::songprojectx-stg-live/*\"}]}"
  }
}
