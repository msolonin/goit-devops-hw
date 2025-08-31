variable "aws_region" {
  description = "Default Region"
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket to store Terraform state"
  type        = string
  default     = "devops-tfstate-msolonin"
}

variable "ecr_name" {
  description = "Name of ecr name"
  type        = string
  default     = "ecr-msolonin-lesson5"
}

variable "dynamodb_table" {
  description = "Name of dynamo db lock table name"
  type        = string
  default     = "terraform-locks"
}

variable "vpc_name" {
  description = "Name of vpc"
  type        = string
  default     = "lesson-5-vpc"
}
