#-------------VPC-----------------
output "vpc_id" {
  description = "ID створеної VPC"
  value       = module.vpc.vpc_id
}
output "public_subnets" {
  description = "Список ID публічних підмереж"
  value       = module.vpc.public_subnets
}
output "private_subnets" {
  description = "Список ID приватних підмереж"
  value       = module.vpc.private_subnets
}

# output "node_group_role_arn" {
#      value = module.eks.node_group_role_arn
# }
#-------------ECR-----------------
output "ecr_repository_url" {
  description = "Повний URL (hostname/імена) для docker push/pull."
  value       = module.ecr.repository_url
}
output "ecr_repository_arn" {
  description = "ARN створеного репозиторію."
  value       = module.ecr.repository_arn
}
#-------------EKS-----------------
output "eks_cluster_endpoint" {
  description = "EKS API endpoint for connecting to the cluster"
  value       = module.eks.eks_cluster_endpoint
}
output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.eks_cluster_name
}
output "eks_node_role_arn" {
  description = "IAM role ARN for EKS Worker Nodes"
  value       = module.eks.eks_node_role_arn
}
output "oidc_provider_arn" {
  description = "OIDC Provider ARN"
  value       = module.eks.oidc_provider_arn
}
output "oidc_provider_url" {
  description = "OIDC Provider URL"
  value       = module.eks.oidc_provider_url
}