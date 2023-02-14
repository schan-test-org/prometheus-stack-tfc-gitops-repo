############################# data :  #######################################

data "terraform_remote_state" "eks" {
  # count = var.vpc_id == "" ? 1 : 0
  # tfstate outputs-list : 
  # how to get : data.terraform_remote_state.eks.0.outputs.xxx 
  backend = "remote"
  config = {
    organization = var.tfc_org
    workspaces = {
      name = var.tfc_wk
    }
  }
}

data "aws_eks_cluster_auth" "cluster" {
  name = local.eks_cluster_name
}
