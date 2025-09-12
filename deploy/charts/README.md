# monitoring

![Version: 4.1.0](https://img.shields.io/badge/Version-4.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 4.1.0](https://img.shields.io/badge/AppVersion-4.1.0-informational?style=flat-square)

A Helm chart for monitoring OpenEBS

## Source Code

* <https://github.com/openebs/monitoring>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.deliveryhero.io/ | node-problem-detector | 2.0.* |
| https://openebs.github.io/dynamic-localpv-provisioner | localpv-provisioner | 4.3.0 |
| https://prometheus-community.github.io/helm-charts | kube-prometheus-stack | 70.10.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` |  |
| kube-prometheus-stack.alertmanager.alertmanagerSpec.replicas | int | `1` |  |
| kube-prometheus-stack.alertmanager.alertmanagerSpec.storage | object | `{}` |  |
| kube-prometheus-stack.alertmanager.config.global.resolve_timeout | string | `"5m"` |  |
| kube-prometheus-stack.alertmanager.config.receivers[0].name | string | `"null"` |  |
| kube-prometheus-stack.alertmanager.config.route.group_by[0] | string | `"alertname"` |  |
| kube-prometheus-stack.alertmanager.config.route.group_by[1] | string | `"job"` |  |
| kube-prometheus-stack.alertmanager.config.route.group_by[2] | string | `"volName"` |  |
| kube-prometheus-stack.alertmanager.config.route.group_interval | string | `"5m"` |  |
| kube-prometheus-stack.alertmanager.config.route.group_wait | string | `"30s"` |  |
| kube-prometheus-stack.alertmanager.config.route.receiver | string | `"null"` |  |
| kube-prometheus-stack.alertmanager.config.route.repeat_interval | string | `"4h"` |  |
| kube-prometheus-stack.alertmanager.config.route.routes[0].matchers[0] | string | `"product=\"openebs\""` |  |
| kube-prometheus-stack.alertmanager.config.route.routes[0].receiver | string | `"null"` |  |
| kube-prometheus-stack.alertmanager.config.templates[0] | string | `"/etc/alertmanager/config/*.tmpl"` |  |
| kube-prometheus-stack.alertmanager.enabled | bool | `true` |  |
| kube-prometheus-stack.alertmanager.service.nodePort | int | `30903` |  |
| kube-prometheus-stack.alertmanager.service.type | string | `"NodePort"` |  |
| kube-prometheus-stack.global.rbac.pspEnabled | bool | `false` |  |
| kube-prometheus-stack.grafana."grafana.ini".panels.disable_sanitize_html | bool | `true` |  |
| kube-prometheus-stack.grafana.adminPassword | string | `"admin"` |  |
| kube-prometheus-stack.grafana.defaultDashboardsEnabled | bool | `true` |  |
| kube-prometheus-stack.grafana.enabled | bool | `true` |  |
| kube-prometheus-stack.grafana.persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| kube-prometheus-stack.grafana.persistence.enabled | bool | `true` |  |
| kube-prometheus-stack.grafana.persistence.size | string | `"1Gi"` |  |
| kube-prometheus-stack.grafana.persistence.storageClassName | string | `"openebs-hostpath"` |  |
| kube-prometheus-stack.grafana.plugins[0] | string | `"grafana-polystat-panel"` |  |
| kube-prometheus-stack.grafana.plugins[1] | string | `"snuids-trafficlights-panel"` |  |
| kube-prometheus-stack.grafana.rbac.pspEnabled | bool | `false` |  |
| kube-prometheus-stack.grafana.service.nodePort | int | `32515` |  |
| kube-prometheus-stack.grafana.service.type | string | `"NodePort"` |  |
| kube-prometheus-stack.grafana.sidecar.dashboards.enabled | bool | `true` |  |
| kube-prometheus-stack.grafana.sidecar.dashboards.label | string | `"grafana_dashboard"` |  |
| kube-prometheus-stack.install | bool | `true` |  |
| kube-prometheus-stack.kube-state-metrics.podSecurityPolicy.enabled | bool | `false` |  |
| kube-prometheus-stack.prometheus-node-exporter.extraArgs[0] | string | `"--collector.filesystem.mount-points-exclude=^/(dev|proc|sys|var/lib/docker/.+)($|/)"` |  |
| kube-prometheus-stack.prometheus-node-exporter.extraArgs[1] | string | `"--collector.filesystem.fs-types-exclude=^(tmpfs|autofs|binfmt_misc|cgroup|configfs|debugfs|devpts|devtmpfs|fusectl|hugetlbfs|mqueue|overlay|proc|procfs|pstore|rpc_pipefs|securityfs|sysfs|tracefs)$"` |  |
| kube-prometheus-stack.prometheus-node-exporter.extraArgs[2] | string | `"--collector.diskstats.device-exclude=^(ram|loop|fd|sr|(h|s|v|xv)d[a-z]+|nvme\\d+n\\d+p|nvme\\d+c\\d+n)\\d+$"` |  |
| kube-prometheus-stack.prometheus-node-exporter.rbac.pspEnabled | bool | `false` |  |
| kube-prometheus-stack.prometheus-node-exporter.securityContext.fsGroup | int | `65534` |  |
| kube-prometheus-stack.prometheus-node-exporter.securityContext.runAsGroup | int | `0` |  |
| kube-prometheus-stack.prometheus-node-exporter.securityContext.runAsNonRoot | bool | `false` |  |
| kube-prometheus-stack.prometheus-node-exporter.securityContext.runAsUser | int | `0` |  |
| kube-prometheus-stack.prometheus-node-exporter.service.port | int | `49201` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.podMonitorSelectorNilUsesHelmValues | bool | `false` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.replicas | int | `1` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.ruleSelectorNilUsesHelmValues | bool | `false` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues | bool | `false` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.metadata.name | string | `"openebs-prometheus-pv"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec.accessModes[0] | string | `"ReadWriteOnce"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec.resources.requests.storage | string | `"1Gi"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec.storageClassName | string | `"openebs-hostpath"` |  |
| kube-prometheus-stack.prometheus.service.nodePort | int | `32514` |  |
| kube-prometheus-stack.prometheus.service.type | string | `"NodePort"` |  |
| kube-prometheus-stack.prometheusOperator.enabled | bool | `true` |  |
| localpv-provisioner.analytics.enabled | bool | `true` |  |
| localpv-provisioner.enabled | bool | `true` |  |
| localpv-provisioner.hostpathClass.enabled | bool | `true` | Enable default hostpath localpv StorageClass. |
| localpv-provisioner.hostpathClass.name | string | `"openebs-hostpath"` |  |
| nameOverride | string | `""` |  |
| namespaceOverride | string | `""` |  |
| node-problem-detector.extraVolumeMounts[0].mountPath | string | `"/dev/kmsg"` |  |
| node-problem-detector.extraVolumeMounts[0].name | string | `"kmsg"` |  |
| node-problem-detector.extraVolumeMounts[0].readOnly | bool | `true` |  |
| node-problem-detector.extraVolumes[0].hostPath.path | string | `"/dev/kmsg"` |  |
| node-problem-detector.extraVolumes[0].name | string | `"kmsg"` |  |
| node-problem-detector.install | bool | `false` |  |
| node-problem-detector.metrics.serviceMonitor.enabled | bool | `true` |  |
| openebsMonitoringAddon.lvmLocalPV.alertRules.enabled | bool | `true` |  |
| openebsMonitoringAddon.lvmLocalPV.dashboards.enabled | bool | `true` |  |
| openebsMonitoringAddon.lvmLocalPV.enabled | bool | `true` |  |
| openebsMonitoringAddon.lvmLocalPV.serviceMonitor.enabled | bool | `true` |  |
| openebsMonitoringAddon.lvmLocalPV.serviceMonitor.endpoints.path | string | `"/metrics"` |  |
| openebsMonitoringAddon.lvmLocalPV.serviceMonitor.endpoints.port | string | `"metrics"` |  |
| openebsMonitoringAddon.lvmLocalPV.serviceMonitor.namespaceSelector.any | bool | `true` |  |
| openebsMonitoringAddon.lvmLocalPV.serviceMonitor.selector.matchLabels.name | string | `"openebs-lvm-node"` |  |
| openebsMonitoringAddon.mayastor.dashboards.enabled | bool | `true` |  |
| openebsMonitoringAddon.mayastor.enabled | bool | `true` |  |
| openebsMonitoringAddon.mayastor.serviceMonitor.enabled | bool | `true` |  |
| openebsMonitoringAddon.mayastor.serviceMonitor.endpoints.path | string | `"/metrics"` |  |
| openebsMonitoringAddon.mayastor.serviceMonitor.endpoints.port | string | `"metrics"` |  |
| openebsMonitoringAddon.mayastor.serviceMonitor.namespaceSelector.any | bool | `true` |  |
| openebsMonitoringAddon.mayastor.serviceMonitor.selector.matchLabels.app | string | `"metrics-exporter-io-engine"` |  |
| openebsMonitoringAddon.npd.alertRules.enabled | bool | `false` |  |
| openebsMonitoringAddon.npd.dashboards.enabled | bool | `false` |  |
| openebsMonitoringAddon.npd.enabled | bool | `false` |  |
| openebsMonitoringAddon.volume.alertRules.enabled | bool | `true` |  |
| openebsMonitoringAddon.volume.enabled | bool | `true` |  |
| openebsMonitoringAddon.zfsLocalPV.dashboards.enabled | bool | `true` |  |
| openebsMonitoringAddon.zfsLocalPV.enabled | bool | `true` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
