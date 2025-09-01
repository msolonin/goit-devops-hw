variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-cluster-msolonin"
}

variable "ecr_repo_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "lesson7-django"
}

variable "vpc_id" {
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

variable "db_name" {
    description = "Name of the EKS cluster"
    type        = string
    default     = "lesson7db" 
}

variable "db_user" {
    description = "Name of the EKS cluster"
    type        = string
    default = "lesson7user"
}

variable "db_password" { 
    description = "Name of the EKS cluster"
    type        = string
    default = "admin123" 
    }
