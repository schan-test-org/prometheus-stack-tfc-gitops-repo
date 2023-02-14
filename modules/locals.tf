locals {
  values = templatefile("${path.module}/template/kube-prometheus-stack-values.tpl", {
    replicas  = var.replica_count
    retention = var.retention

    external_labels = var.external_labels
    remote_write    = var.remote_write
    remote_write_dashboards = var.remote_write_dashboards

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

    affinity    = var.affinity
    tolerations = var.tolerations
  })

  network_policy_yaml = templatefile("${path.module}/template/simple-prometheus-network-policy.tpl", {
    namespace         = var.namespace
    kubernetes_api_ip = format("%s/32", cidrhost(data.aws_eks_cluster.cluster.kubernetes_network_config[0].service_ipv4_cidr, 1))
    pod_ip_range      = data.aws_vpc.vpc.cidr_block
  })
}
