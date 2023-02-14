variable "project" {
  type        = string
  default     = ""
  description = "project code which used to compose the resource name"
}

variable "env" {
  type        = string
  default     = ""
  description = "environment: dev, stg, qa, prod "
}

variable "region" {
  type        = string
  default     = ""
  description = "aws region to build network infrastructure"
}

variable "common_tags" {
  type        = map(any)
  default     = {}
  description = "chart version for ebs csi controller"
}

variable "eks_cluster_name" {
  type        = string
  default     = ""
  description = "eks cluster name"
}

variable "eks_endpoint_url" {
  type        = string
  default     = ""
  description = "url of eks master."
}

variable "eks_cluster_certificate_authority_data" {
  type        = string
  default     = ""
  description = "PEM-encoded root certificates bundle for TLS authentication."
}

variable "eks_auth_token" {
  type        = string
  default     = ""
  description = "eks cluster auth token"
}

variable "helm_release_name" {
  type        = string
  default     = ""
  description = "helm release name"
}

variable "helm_chart_name" {
  type        = string
  default     = ""
  description = "helm chart name"
}

variable "helm_chart_version" {
  type        = string
  default     = ""
  description = "helm chart version"
}

variable "helm_repository_url" {
  type        = string
  default     = ""
  description = "helm chart repository url"
}

variable "create_namespace" {
  type        = bool
  default     = true
  description = "create the namespace if it does not yet exist"
}

variable "namespace" {
  type        = string
  default     = "kube-system"
  description = "namespace to install"
}

variable "replica_count" {
  type        = number
  default     = 1
  description = "ingress class name"
}

variable "retention" {
  type        = string
  default     = "10d"
  description = "How long to retain metrics"
}

variable "prometheus_enabled" {
  type    = bool
  default = false
}

variable "prometheus_ingress_enabled" {
  type    = bool
  default = false
}

variable "prometheus_ingress_annotations" {
  type    = string
  default = ""
}

variable "prometheus_host" {
  type    = string
  default = ""
}

variable "alertmanager_enabled" {
  type    = bool
  default = false
}

variable "alertmanager_ingress_enabled" {
  type    = bool
  default = false
}

variable "alertmanager_ingress_annotations" {
  type    = string
  default = ""
}

variable "alertmanager_host" {
  type    = string
  default = ""
}

variable "grafana_enabled" {
  type    = bool
  default = false
}

variable "grafana_ingress_enabled" {
  type    = bool
  default = false
}

variable "grafana_ingress_annotations" {
  type    = string
  default = ""
}

variable "grafana_host" {
  type    = string
  default = ""
}

variable "grafana_ini" {
  type    = string
  default = ""
}

variable "prometheus_volume_enabled" {
  type    = bool
  default = false
}

variable "prometheus_volume_size" {
  type    = string
  default = "10Gi"
}

variable "alertmanager_volume_enabled" {
  type    = bool
  default = false
}

variable "alertmanager_volume_size" {
  type    = string
  default = "10Gi"
}

variable "grafana_volume_enabled" {
  type    = bool
  default = false
}

variable "grafana_volume_size" {
  type    = string
  default = "10Gi"
}

variable "resources" {
  type    = string
  default = ""
}

variable "affinity" {
  type    = string
  default = ""
}

variable "tolerations" {
  type    = string
  default = ""
}

variable "node_selector" {
  type    = string
  default = ""
}

variable "topology_spread_constraints" {
  type    = string
  default = ""
}

variable "external_labels" {
  type        = string
  default     = ""
  description = "External labels to add to any time series or alerts when communicating with external systems"
}

variable "remote_write" {
  type        = string
  default     = ""
  description = "The remote_write spec configuration for Prometheus."
}

variable "remote_write_dashboards" {
  type    = bool
  default = false
}


variable "networkpolicy_enabled" {
  type        = bool
  default     = false
  description = "Set to true if NetworkPolicy is required"
}

variable "additional_prometheus_rules" {
  type        = string
  default     = ""
  description = "add prometheus rules"
}