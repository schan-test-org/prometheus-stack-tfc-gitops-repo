########################################
# Common
########################################
project     = "dev-eks-prj"
aws_region  = "ap-northeast-2"
env             = "dev"

default_tags = {
  dept  = "DEVOPS/TERRAFORM-CLOUD-GITOPS-TESTING"
}

########################################
# workspace setting
########################################
tfc_org = "schan-test"
tfc_wk = "dev-eks-tfc"

########################################
# etc setting
########################################
eks_cluster_name       = "test-deveks"

########################################
# helm
########################################
# external_labels = ""
external_labels = <<EOT
cluster: test-deveks
EOT

helm_release_name = "prometheus-release"
helm_chart_name   = "kube-prometheus-stack"
# helm_chart_version = "35.4.2"
helm_chart_version  = "43.2.1"
helm_repository_url = "https://prometheus-community.github.io/helm-charts"

create_namespace = true
namespace        = "prometheus"
replica_count    = 1
retention        = "15d"

remote_write_dashboards = false
remote_write            = ""

# remote_write = <<EOT
# - name: heimdall-dev
#   url: http://metrics-shipper-service.heimdall-apps.svc.cluster.local:8080/prometheus
#   remoteTimeout: "10s"
#   headers:
#     X-Scope-OrgID: psa-devops-heimdall-dev
# # - name: heimdall-dev-external
# #   # url: http://mimir-release-nginx.grafana-mimir.svc.cluster.local/api/v1/push
# #   url: https://incoming.heimdall.gq/prometheus
# #   remoteTimeout: "10s"
# #   headers:
# #     X-Scope-OrgID: psa-devops-heimdall-dev-external
# EOT

########################################
# prometheus-alb
########################################
prometheus_enabled             = true
prometheus_ingress_enabled     = true
prometheus_host                = "prometheus.supk.xyz"
prometheus_ingress_annotations = <<EOT
kubernetes.io/ingress.class: alb
alb.ingress.kubernetes.io/scheme: internet-facing
alb.ingress.kubernetes.io/target-type: ip
kubernetes.io/tls-acme: "true"
alb.ingress.kubernetes.io/load-balancer-name: promt-ops-stack
alb.ingress.kubernetes.io/group.name: kube-prometheus-stack
alb.ingress.kubernetes.io/group.order: "1"
alb.ingress.kubernetes.io/subnets: subnet-0fbc809bfc2f2760e, subnet-09ab27b079a2aa375
alb.ingress.kubernetes.io/certificate-arn: arn:aws:acm:ap-northeast-2:524542846721:certificate/bb52c420-ccac-415c-9d51-8b42417bc886
alb.ingress.kubernetes.io/backend-protocol: HTTP
alb.ingress.kubernetes.io/success-codes: "200,301,302"
alb.ingress.kubernetes.io/load-balancer-attributes: deletion_protection.enabled=false
alb.ingress.kubernetes.io/listen-ports: '[{"HTTPS": 443}, {"HTTP": 80}]'
alb.ingress.kubernetes.io/ssl-redirect: '443'
EOT

########################################
# alertmanager-alb
########################################
alertmanager_enabled             = true
alertmanager_ingress_enabled     = true
alertmanager_host                = "alertmanager.supk.xyz"
alertmanager_ingress_annotations = <<EOT
kubernetes.io/ingress.class: alb
alb.ingress.kubernetes.io/scheme: internet-facing
alb.ingress.kubernetes.io/target-type: ip
kubernetes.io/tls-acme: "true"
alb.ingress.kubernetes.io/load-balancer-name: promt-ops-stack
alb.ingress.kubernetes.io/group.name: kube-prometheus-stack
alb.ingress.kubernetes.io/group.order: "2"
alb.ingress.kubernetes.io/subnets: subnet-0fbc809bfc2f2760e, subnet-09ab27b079a2aa375
alb.ingress.kubernetes.io/certificate-arn: arn:aws:acm:ap-northeast-2:524542846721:certificate/bb52c420-ccac-415c-9d51-8b42417bc886
alb.ingress.kubernetes.io/backend-protocol: HTTP
alb.ingress.kubernetes.io/success-codes: "200,301,302"
alb.ingress.kubernetes.io/load-balancer-attributes: deletion_protection.enabled=false
alb.ingress.kubernetes.io/listen-ports: '[{"HTTPS": 443}, {"HTTP": 80}]'
alb.ingress.kubernetes.io/ssl-redirect: '443'
EOT

########################################
# grafana-alb
########################################
grafana_enabled             = true
grafana_ingress_enabled     = true
grafana_host                = "grafana.supk.xyz"
grafana_ingress_annotations = <<EOT
kubernetes.io/ingress.class: alb
alb.ingress.kubernetes.io/scheme: internet-facing
alb.ingress.kubernetes.io/target-type: ip
kubernetes.io/tls-acme: "true"
alb.ingress.kubernetes.io/load-balancer-name: promt-ops-stack
alb.ingress.kubernetes.io/group.name: kube-prometheus-stack
alb.ingress.kubernetes.io/group.order: "3"
alb.ingress.kubernetes.io/subnets: subnet-0fbc809bfc2f2760e, subnet-09ab27b079a2aa375
alb.ingress.kubernetes.io/certificate-arn: arn:aws:acm:ap-northeast-2:524542846721:certificate/bb52c420-ccac-415c-9d51-8b42417bc886
alb.ingress.kubernetes.io/backend-protocol: HTTP
alb.ingress.kubernetes.io/success-codes: "200,301,302"
alb.ingress.kubernetes.io/load-balancer-attributes: deletion_protection.enabled=false
alb.ingress.kubernetes.io/listen-ports: '[{"HTTPS": 443}, {"HTTP": 80}]'
alb.ingress.kubernetes.io/ssl-redirect: '443'
EOT

# grafana_ini = <<EOT
# unified_alerting:
#   enabled: true
# alerting:
#   enabled: false
# EOT

prometheus_volume_enabled = true
prometheus_volume_size    = "30Gi"

grafana_volume_enabled = true
grafana_volume_size    = "10Gi"

alertmanager_volume_enabled = true
alertmanager_volume_size    = "10Gi"

#################################
# resources = <<EOF
# limits:
#   memory: "100Mi"
# requests:
#   cpu: "100m"
#   memory: "100Mi"
# EOF


#################################
# node_selector = ""
# # node_selector = <<EOF
# # role: ops
# # EOF

#################################

affinity = <<EOF
nodeAffinity:
  requiredDuringSchedulingIgnoredDuringExecution:
    nodeSelectorTerms:
    - matchExpressions:
      - key: role
        operator: In
        values:
        - ops
EOF

tolerations = <<EOF
- key: "role"
  operator: "Equal"
  value: "ops"
  effect: "NoSchedule"
EOF
#################################

additional_prometheus_rules = ""







