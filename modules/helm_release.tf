resource "helm_release" "prometheus" {
  name       = var.helm_release_name
  chart      = var.helm_chart_name
  version    = var.helm_chart_version
  repository = var.helm_repository_url

  create_namespace = var.create_namespace
  namespace        = var.namespace

  values = [
    local.values,
  ]

  depends_on = [
    kubernetes_manifest.simple-prometheus-network-policy
  ]
}
