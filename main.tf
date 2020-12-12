# Configure the AWS Provider
provider "aws" {
  region                  = var.region
  shared_credentials_file = "$HOME/.aws/credentials"
  profile                 = "terraform"
}

# Configure the remote state using S3 and Locking mechanism using Dynamo DB
terraform {
  backend "s3" {
    bucket  = "eks-rds-terraform"
    key     = "leafshhets-prod"
    region  = "us-east-1"
    dynamodb_table = "terraform-lock-prod"
  }
}

# Kubernetes provider
provider "kubernetes" {
  load_config_file       = "false"
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}
