############################# main : var #######################################

variable "env" { type = string }
variable "aws_region" { type = string }
variable "project" { type = string }
variable "default_tags" { type = map(string) }

############################# bknd & vpc & network about : var #######################################
variable "tfc_org" { default = "" }
variable "tfc_wk" { default = "" }

############################# eks-cluster : var #######################################
variable "eks_cluster_name" { default = "" }
variable "eks_endpoint_url" { default = "" }
variable "eks_cluster_certificate_authority_data" { default = "" }
variable "eks_auth_token" { default = "" }

############################# helm : var #######################################
variable "helm_release_name" { default = "" }
variable "helm_chart_name" { default = "" }
variable "helm_chart_version" { default = "" }
variable "helm_repository_url" { default = "" }
variable "create_namespace" { default = true }
variable "namespace" { default = "kube-system" }

############################# others : var #######################################

variable "replica_count" { default = 1 }

variable "retention" { default = "10d" }

variable "prometheus_enabled" { default = false }

variable "prometheus_ingress_enabled" { default = false }

variable "prometheus_ingress_annotations" { default = "" }

variable "prometheus_host" { default = "" }

variable "alertmanager_enabled" { default = false }

variable "alertmanager_ingress_enabled" { default = false }

variable "alertmanager_ingress_annotations" { default = "" }

variable "alertmanager_host" { default = "" }

variable "grafana_enabled" { default = false }

variable "grafana_ingress_enabled" { default = false }

variable "grafana_ingress_annotations" { default = "" }

variable "grafana_host" { default = "" }

variable "grafana_ini" { default = "" }

variable "prometheus_volume_enabled" { default = false }

variable "prometheus_volume_size" { default = "10Gi" }

variable "alertmanager_volume_enabled" { default = false }

variable "alertmanager_volume_size" { default = "10Gi" }

variable "grafana_volume_enabled" { default = false }

variable "grafana_volume_size" { default = "10Gi" }

variable "affinity" { default = "" }
variable "external_labels" { default = "" }
############################# others : 2nd var #######################################

variable "resources" { default = "" }
variable "tolerations" { default = "" }
variable "node_selector" { default = "" }
variable "topology_spread_constraints" { default = "" }

variable "remote_write" { default = "" }

variable "remote_write_dashboards" { default = false }

variable "networkpolicy_enabled" { default = false }

variable "additional_prometheus_rules" { default = "" }