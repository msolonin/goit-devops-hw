
output "dynamodb_table_name" {
  description = "Name of the DynamoDB lock table"
  value       = aws_dynamodb_table.terraform_locks.name
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = var.bucket_name
}

output "s3_bucket_url" {
  description = "Regional URL of the S3 bucket"
  value       = "https://${var.bucket_name}.s3.amazonaws.com"
}
