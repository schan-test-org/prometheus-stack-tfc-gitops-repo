############################################
# version of terraform and providers
############################################
terraform {
  cloud {
    organization = "schan-test"

    workspaces {}
  }
}


############################################
# AWS Provider Configuration
############################################
provider "aws" {
  region  = var.aws_region
  # profile = var.aws_profile

}

provider "helm" {
  kubernetes {
    cluster_ca_certificate = base64decode(local.eks_cluster_certificate_authority_data)
    host                   = local.eks_endpoint_url
    token                  = local.eks_auth_token
  }
}

provider "kubernetes" {
  cluster_ca_certificate = base64decode(local.eks_cluster_certificate_authority_data)
  host                   = local.eks_endpoint_url
  token                  = local.eks_auth_token
}