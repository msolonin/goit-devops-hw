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
  vpc_cidr_block     = "10.0.0.0/16"                                        # CIDR блок для VPC
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]        # Публічні підмережі
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]        # Приватні підмережі
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]  # Зони доступності
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