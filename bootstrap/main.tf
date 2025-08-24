provider "aws" {
  region = var.aws_region
}

# Create S3-Bucket
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name
  tags = {
    Name        = "Terraform State Bucket"
    Environment = var.env_name
  }
}

# Configure versionning for S3-Bucket
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Install control of ownership for S3-Bucket
resource "aws_s3_bucket_ownership_controls" "terraform_state_ownership" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# # S3 bucket for Terraform state
# resource "aws_s3_bucket" "tf_state" {
#   bucket = var.bucket_name

#   tags = {
#     Name        = "tfstate-bucket"
#     Environment = var.environment
#   }
# }

# # Enable versioning
# resource "aws_s3_bucket_versioning" "tf_state" {
#   bucket = aws_s3_bucket.tf_state.id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# # Server-side encryption
# resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state" {
#   bucket = aws_s3_bucket.tf_state.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# Block public access
# resource "aws_s3_bucket_public_access_block" "tf_state_block" {
#   bucket = aws_s3_bucket.tf_state.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# DynamoDB for state locking
# resource "aws_dynamodb_table" "tf_lock" {
#   name         = var.lock_name
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }
