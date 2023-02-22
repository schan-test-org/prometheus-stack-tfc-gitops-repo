locals {
  # set eks variables from backend s3
  eks_cluster_name                       = var.eks_cluster_name == "" ? data.terraform_remote_state.eks.outputs.eks_cluster_name : var.eks_cluster_name
  eks_endpoint_url                       = var.eks_endpoint_url == "" ? data.terraform_remote_state.eks.outputs.eks_cluster_endpoint : var.eks_endpoint_url
  eks_cluster_certificate_authority_data = var.eks_cluster_certificate_authority_data == "" ? data.terraform_remote_state.eks.outputs.eks_cluster_certificate_authority_data : var.eks_cluster_certificate_authority_data
  eks_auth_token                         = data.aws_eks_cluster_auth.cluster.token

  common_tags = merge(var.default_tags, {
    "region"  = var.aws_region
    "project" = var.project
    "env"     = var.env
    "managed" = "terraform"
  })

  region                    = var.aws_region
}

# resource "kubernetes_storage_class" "gp3" {
#   metadata {
#     name = "gp3"
#   }
#   storage_provisioner = "ebs.csi.aws.com"
#   volume_binding_mode = "WaitForFirstConsumer"
#   reclaim_policy = "Delete"
#   parameters = {
#     type = "gp3"
#   } 
#   allowed_topologies {
#     match_label_expressions {
#       key = "topology.ebs.csi.aws.com/zone"
#       values = [
#         "ap-northeast-2a",
#         "ap-northeast-2c"
#       ]
#     }
#   }
# }