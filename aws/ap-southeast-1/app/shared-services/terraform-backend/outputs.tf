output "s3_bucket_arn" {
  value = module.s3_bucket.s3_bucket_arn
}

output "dynamodb_table_arn" {
  value = aws_dynamodb_table.this.arn
}