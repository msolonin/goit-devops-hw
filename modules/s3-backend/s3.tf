# # Create S3-Bucket
# resource "aws_s3_bucket" "terraform_state" {
#   bucket = var.bucket_name
#   tags = {
#     Name        = "Terraform State Bucket"
#     Environment = var.env_name
#   }
# }

# # Configure versionning for S3-Bucket
# resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
#   bucket = aws_s3_bucket.terraform_state.id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# # Install control of ownership for S3-Bucket
# resource "aws_s3_bucket_ownership_controls" "terraform_state_ownership" {
#   bucket = aws_s3_bucket.terraform_state.id
#   rule {
#     object_ownership = "BucketOwnerEnforced"
#   }
# }