module "kube-prometheus-stack" {
  source = "./modules"

  project = var.project
  env     = var.env
  region  = local.region

  eks_cluster_name                       = local.eks_cluster_name
  eks_endpoint_url                       = local.eks_endpoint_url
  eks_cluster_certificate_authority_data = local.eks_cluster_certificate_authority_data
  eks_auth_token                         = local.eks_auth_token

  helm_release_name   = var.helm_release_name
  helm_chart_name     = var.helm_chart_name
  helm_chart_version  = var.helm_chart_version
  helm_repository_url = var.helm_repository_url

  create_namespace = var.create_namespace
  namespace        = var.namespace
  replica_count    = var.replica_count
  retention        = var.retention

  external_labels             = var.external_labels
  remote_write                = var.remote_write
  remote_write_dashboards     = var.remote_write_dashboards
  additional_prometheus_rules = var.additional_prometheus_rules

  prometheus_enabled             = var.prometheus_enabled
  prometheus_ingress_enabled     = var.prometheus_ingress_enabled
  prometheus_ingress_annotations = var.prometheus_ingress_annotations
  prometheus_host                = var.prometheus_host

  alertmanager_enabled             = var.alertmanager_enabled
  alertmanager_ingress_enabled     = var.alertmanager_ingress_enabled
  alertmanager_ingress_annotations = var.alertmanager_ingress_annotations
  alertmanager_host                = var.alertmanager_host

  grafana_enabled             = var.grafana_enabled
  grafana_ingress_enabled     = var.grafana_ingress_enabled
  grafana_ingress_annotations = var.grafana_ingress_annotations
  grafana_host                = var.grafana_host
  grafana_ini                 = var.grafana_ini

  prometheus_volume_enabled = var.prometheus_volume_enabled
  prometheus_volume_size    = var.prometheus_volume_size

  alertmanager_volume_enabled = var.alertmanager_volume_enabled
  alertmanager_volume_size    = var.alertmanager_volume_size

  grafana_volume_enabled = var.grafana_volume_enabled
  grafana_volume_size    = var.grafana_volume_size

  resources                   = var.resources
  affinity                    = var.affinity
  node_selector               = var.node_selector
  tolerations                 = var.tolerations
  topology_spread_constraints = var.topology_spread_constraints

  common_tags = local.common_tags

  networkpolicy_enabled = var.networkpolicy_enabled
}
