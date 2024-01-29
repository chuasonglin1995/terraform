# This is a newer feature of Terraform that allows you to generate TF codes for existing resources 
# terraform plan -generate-config-out=generated.tf

import {
  # id → The id of the resource used in your cloud provider
  id = "S3TriggerImageResizeRole"
  # to → The resource address that will be used in Terraform
  to = aws_iam_role.this
}


