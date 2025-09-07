terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}
provider "aws" {
  region = var.region
}
# Підключаємо модуль для S3 та DynamoDB
#module "s3_backend" {
#  source      = "./modules/s3-backend"                    # Шлях до модуля
#  bucket_name = "terraform-state-bucket-18062025214500"   # Ім'я S3-бакета
#  table_name  = "use_lockfile"                            # Ім'я DynamoDB
#}
# Підключаємо модуль для VPC
module "vpc" {
  source             = "./modules/vpc"                                      # Шлях до модуля VPC
  vpc_cidr_block     = var.vpc_cidr_block                                # CIDR блок для VPC
  public_subnets     = var.public_subnets        # Публічні підмережі
  private_subnets    = var.private_subnets        # Приватні підмережі
  availability_zones = var.availability_zones  # Зони доступності
  vpc_name           = var.vpc_name                                         # Ім'я VPC
}

# Підключаємо модуль для ECR
module "ecr" {
  source = "./modules/ecr"
  repository_name = var.repository_name          # Ім'я репозиторію
  scan_on_push    = true                         # true → увімкнути
}

module "eks" {
  source        = "./modules/eks"
  cluster_name  = var.cluster_name              # Назва кластера
  subnet_ids    = module.vpc.public_subnets     # ID підмереж
  instance_type = var.instance_type             # Тип інстансів
  desired_size  = 2                             # Бажана кількість нодів
  max_size      = 3                             # Максимальна кількість нодів
  min_size      = 1                             # Мінімальна кількість нодів
}
data "aws_eks_cluster" "eks" {
  name       = module.eks.eks_cluster_name
  depends_on = [module.eks]
}
data "aws_eks_cluster_auth" "eks" {
  name       = module.eks.eks_cluster_name
  depends_on = [module.eks]
}
provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}
provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}

module "jenkins" {
  source            = "./modules/jenkins"
  cluster_name      = module.eks.eks_cluster_name
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.oidc_provider_url
  github_pat        = var.github_pat
  github_user       = var.github_user
  github_repo_url   = var.github_repo_url
  depends_on        = [module.eks]
  providers         = {
    helm       = helm
    kubernetes = kubernetes
  }
}

module "argo_cd" {
  source        = "./modules/argo_cd"
  namespace     = "argocd"
  chart_version = "5.46.4"
  depends_on    = [module.eks]
}

module "rds" {
  source = "./modules/rds"
  name                = var.name
  use_aurora          = var.use_aurora
  db_name             = var.db_name
  username            = var.username
  password            = var.password
  instance_class      = var.instance_class
  engine              = var.engine
  engine_version      = var.engine_version
  engine_cluster      = var.engine_cluster
  engine_version_cluster = var.engine_version_cluster
  multi_az            = var.multi_az
  publicly_accessible = var.publicly_accessible
  backup_retention_period = var.backup_retention_period
  aurora_replica_count    = var.aurora_replica_count

  vpc_id             = module.vpc.vpc_id
  vpc_cidr_block     = var.vpc_cidr_block
  subnet_private_ids = module.vpc.private_subnets
  subnet_public_ids  = module.vpc.public_subnets

  parameter_group_family_rds    = var.parameter_group_family_rds
  parameter_group_family_aurora = var.parameter_group_family_aurora

  parameters = {
    max_connections = "200"
    log_statement   = "none"
    work_mem        = "4096"
  }

  tags = {
    Environment = var.environment
    Project     = var.project
  }
  depends_on = [module.vpc]
}
