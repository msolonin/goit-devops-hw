variable "aws_region" {
  description = "Default Region"
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket to store Terraform state"
  type        = string
  default     = "devops-tfstate-msolonin"
}

variable "environment" {
  description = "Backend environment"
  default = "dev"
}

variable "lock_name" {
  description = "Name of lock name"
  type        = string
  default     = "terraform-locks"
}

variable "env_name" {
  description = "Default env name"
  type        = string
  default     = "lesson-5"
}
