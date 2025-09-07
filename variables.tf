variable "region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-cluster-msolonin"
}
variable "vpc_name" {
  default = "vpc-msolonin"
}
variable "instance_type" {

  description = "EC2 instance type for the worker nodes"
  type        = string
  default     = "t3.medium"
}
variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "ecr-repo-18062025214500"
}
// github credentials
variable "github_pat" {
  description = "GitHub Personal Access Token"
  type        = string
}
variable "github_user" {
  description = "GitHub username"
  type        = string
}
variable "github_repo_url" {
  description = "GitHub repository name"
  type        = string
}

// RDS variables
variable "name" {
  description = "Назва інстансу або кластера"
  type        = string
  default     = "rds-cluster"
}

variable "use_aurora" {
  description = "Чи використовувати Aurora (true) або стандартний RDS (false)"
  type        = bool
  default     = false
}

variable "db_name" {
  description = "Назва бази даних"
  type        = string
  default     = "msolonin_rds"
}

variable "username" {
  description = "Master username"
  type        = string
}

variable "password" {
  description = "Master password"
  type        = string
  sensitive   = true
}

# Engine settings
variable "engine" {
  type    = string
  default = "postgres"
}

variable "engine_version" {
  type    = string
  default = "14.19"
}

variable "engine_cluster" {
  type    = string
  default = "aurora-postgresql"
}

variable "engine_version_cluster" {
  type    = string
  default = "15.14"
}

variable "instance_class" {
  type    = string
  default = "db.t3.medium"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "publicly_accessible" {
  type    = bool
  default = false
}

variable "backup_retention_period" {
  type        = number
  default     = 7
  description = "Кількість днів для збереження бекапів"
}

# Aurora replicas
variable "aurora_replica_count" {
  type    = number
  default = 1
}

# Parameter groups
variable "parameter_group_family_rds" {
  type    = string
  default = "postgres14"
}

variable "parameter_group_family_aurora" {
  type    = string
  default = "aurora-postgresql15"
}

variable "parameters" {
  type    = map(string)
  default = {}
}

# Networking

variable "vpc_cidr_block" {
  description = "CIDR блок для VPC"
  type        = string
  default     = "10.0.0.0/16" 
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# Tags
variable "tags" {
  type    = map(string)
  default = {}
}

variable "environment" {
  description = "Назва середовища (наприклад: dev, stage, prod)"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "Назва проекту"
  type        = string
  default     = "goit"
}
