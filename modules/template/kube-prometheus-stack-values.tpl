nameOverride: ""
namespaceOverride: ""
kubeTargetVersionOverride: "1.22"
kubeVersionOverride: ""
fullnameOverride: ""

commonLabels: {}

## Create default rules for monitoring the cluster
##
defaultRules:
  create: true

  labels:
  #  tenant: mzc
  #  project: heimdall
  #  env: prod
    region: ap-northeast-2
  
  disabled: {}
  # KubeAPIDown: true
  # NodeRAIDDegraded: true

%{ if additional_prometheus_rules != "" ~}
additionalPrometheusRulesMap:
  rule-name:
    ${indent(4, additional_prometheus_rules)}
%{ endif ~}

alertmanager:
  enabled: ${alertmanager_enabled}
  annotations: {}

  ingress:
    enabled: ${alertmanager_ingress_enabled}
%{ if alertmanager_ingress_enabled == true && alertmanager_ingress_annotations != "" ~}
    annotations:
      ${indent(6, alertmanager_ingress_annotations)}
    hosts:
    - ${alertmanager_host}
%{ endif ~}

    ## Paths to use for ingress rules - one path should match the alertmanagerSpec.routePrefix
    ##
    paths:
    - "/*"

  alertmanagerSpec:
    logFormat: logfmt
    logLevel: info
    replicas: 1
    retention: 120h
%{ if alertmanager_volume_enabled == true ~}
    storage:
      volumeClaimTemplate:
        spec:
          storageClassName: "gp3"
          accessModes: ["ReadWriteOnce"]
          resources:
            requests:
              storage: ${alertmanager_volume_size}
%{ endif ~}
    nodeSelector: {}
    resources: {}
    podAntiAffinity: ""
    podAntiAffinityTopologyKey: kubernetes.io/hostname
%{ if affinity != "" ~}
    affinity:
      ${indent(6, affinity)}
%{ endif ~}
%{ if tolerations != "" ~}
    tolerations:
      ${indent(6, tolerations)}
%{ endif ~}

grafana:
  enabled: ${grafana_enabled}
  namespaceOverride: ""
  forceDeployDatasources: false
  forceDeployDashboards: false
  defaultDashboardsEnabled: true

  ## Timezone for the default dashboards
  ## Other options are: browser or a specific timezone, i.e. Europe/Luxembourg
  ##
  defaultDashboardsTimezone: "Asia/Seoul"

  adminPassword: "devops123"

  ingress:
    enabled: ${grafana_ingress_enabled}
%{ if grafana_ingress_enabled == true && grafana_ingress_annotations != "" ~}
    annotations:
      ${indent(6, grafana_ingress_annotations)}
    hosts:
    - ${grafana_host}
%{ endif ~}
    path: /

  resources: {}
  nodeSelector: {}
%{ if tolerations != "" ~}
  tolerations:
    ${indent(4, tolerations)}
%{ endif ~}

%{ if affinity != "" ~}
  affinity:
    ${indent(4, affinity)}
%{ endif ~}

%{ if grafana_volume_enabled == true ~}
  persistence:
    enabled: true
    type: pvc
    storageClassName: "gp3"
    accessModes:
    - ReadWriteOnce
    size: ${grafana_volume_size}
    finalizers:
    - kubernetes.io/pvc-protection
%{ endif ~}
%{ if grafana_ini != "" ~}
  grafana.ini:
    ${indent(4, grafana_ini)}
%{ endif ~}

## Component scraping the kube api server
kubeApiServer:
  enabled: true

## Component scraping the kubelet and kubelet-hosted cAdvisor
##
kubelet:
  enabled: true
  namespace: kube-system

## Component scraping the kube controller manager
##
kubeControllerManager:
  enabled: true

## Component scraping coreDns. Use either this or kubeDns
##
coreDns:
  enabled: true

## Component scraping kubeDns. Use either this or coreDns
##
kubeDns:
  enabled: false

## Component scraping etcd
##
kubeEtcd:
  enabled: true

## Component scraping kube scheduler
##
kubeScheduler:
  enabled: true

## Component scraping kube proxy
##
kubeProxy:
  enabled: true

## Component scraping kube state metrics
##
kubeStateMetrics:
  enabled: true

## Configuration for kube-state-metrics subchart
##
kube-state-metrics:
  exteraArgs:
  - '--metric-labels-allowlist=nodes=[eks.amazonaws.com/nodegroup]'
%{ if affinity != "" ~}
  affinity:
    ${indent(4, affinity)}
%{ endif ~}

%{ if tolerations != "" ~}
  tolerations:
    ${indent(4, tolerations)}
%{ endif ~}

## Deploy node exporter as a daemonset to all nodes
##
nodeExporter:
  enabled: true

## Configuration for prometheus-node-exporter subchart
##
prometheus-node-exporter:
  namespaceOverride: ""

## Manages Prometheus and Alertmanager components
##
prometheusOperator:
  enabled: true
  tls:
    enabled: true

%{ if affinity != "" ~}
  affinity:
    ${indent(4, affinity)}
%{ endif ~}

%{ if tolerations != "" ~}
  tolerations:
    ${indent(4, tolerations)}
%{ endif ~}

  logFormat: logfmt
  logLevel: error

  resources: {}
  hostNetwork: false

%{ if tolerations != "" ~}
  tolerations:
    ${indent(4, tolerations)}
%{ endif ~}
%{ if affinity != "" ~}
  affinity:
    ${indent(4, affinity)}
%{ endif ~}

prometheus:
  enabled: ${prometheus_enabled}

  ingress:
    enabled: ${prometheus_ingress_enabled}

    # For Kubernetes >= 1.18 you should specify the ingress-controller via the field ingressClassName
    # See https://kubernetes.io/blog/2020/04/02/improvements-to-the-ingress-api-in-kubernetes-1.18/#specifying-the-class-of-an-ingress
    # ingressClassName: nginx

%{ if prometheus_ingress_enabled == true && prometheus_ingress_annotations != "" ~}
    annotations:
      ${indent(6, prometheus_ingress_annotations)}
%{ endif ~}
%{ if prometheus_ingress_enabled == true ~}
    hosts:
    - ${prometheus_host}
%{ endif ~}
    paths:
    - "/*"

  prometheusSpec:
    serviceMonitorSelectorNilUsesHelmValues: false 
%{ if tolerations != "" ~}
    tolerations:
      ${indent(6, tolerations)}
%{ endif ~}
%{ if external_labels != "" ~}
    externalLabels:
      ${indent(6, external_labels)}
%{ endif ~}
%{ if affinity != "" ~}
    affinity:
      ${indent(6, affinity)}
%{ endif ~}
%{ if remote_write != "" ~}
    remoteWrite:
      ${indent(6, remote_write)}
%{ endif ~}
    remoteWriteDashboards: ${remote_write_dashboards}
    resources: {}
%{ if prometheus_volume_enabled == true ~}
    storageSpec:
      volumeClaimTemplate:
        spec:
          storageClassName: gp3
          accessModes: ["ReadWriteOnce"]
          resources:
            requests:
              storage: ${prometheus_volume_size}
%{ endif ~}

