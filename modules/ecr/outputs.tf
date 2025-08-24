output "ecr_repo_url" {
  description = "Full ECR repository URL for docker push/pull"
  value       = "https://${aws_ecr_repository.ecr.repository_url}"
}

output "ecr_repo_arn" {
  description = "ARN of the ECR repository"
  value       = aws_ecr_repository.ecr.arn
}