resource "kubernetes_manifest" "simple-prometheus-network-policy" {
  count = var.networkpolicy_enabled ? 1 : 0

  manifest = yamldecode(local.network_policy_yaml)

  depends_on = [
    kubernetes_namespace.namespace
  ]
}
