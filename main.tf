# Connect S3 та DynamoDB
module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = var.bucket_name
  dynamodb_table  = var.dynamodb_table
}

# Підключаємо модуль VPC
module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  vpc_name           = var.vpc_name
}

# Підключаємо модуль ECR
module "ecr" {
  source      = "./modules/ecr"
  ecr_name    = var.ecr_name
  force_delete = false
  scan_on_push = true
  image_tag_mutability = "MUTABLE"
}
