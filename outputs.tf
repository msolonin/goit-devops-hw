output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = module.s3_backend.s3_bucket_name
}

output "s3_bucket_url" {
  description = "The url of the S3 bucket"
  value       = module.s3_backend.s3_bucket_url
}

output "vpc_id" {
  description = "The Id of VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet" {
  description = "Public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnet" {
  description = "Private subnets"
  value       = module.vpc.private_subnets
}

output "ecr_repo_url" {
  description = "ECR repository URL"
  value       = module.ecr.ecr_repo_url
}
