resource "kubernetes_namespace" "namespace" {
  count = var.create_namespace ? 1 : 0
  metadata {
    labels = {
      role = "monitoring"
    }

    name = var.namespace
  }
}
