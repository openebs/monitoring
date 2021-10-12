# OpenEBS Monitoring

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
![Chart Lint and Test](https://github.com/openebs/monitoring/workflows/Chart%20Lint%20and%20Test/badge.svg)
![Release Charts](https://github.com/openebs/monitoring/workflows/Release%20Charts/badge.svg?branch=develop)

A Helm chart for openebs monitoring. This chart bootstraps OpenEBS monitoring stack on a [Kubernetes](http://kubernetes.io) cluster using the  
[Helm](https://helm.sh) package manager.

**Homepage:** <http://www.openebs.io/>

## Maintainers

| Name       | Email                        | Url |
| ---------- | ---------------------------- | --- |
| kiranmova  | kiran.mova@mayadata.io       |     |
| avishnu    | vishnu.attur@mayadata.io     |     |
| Ab-hishek  | abhishek.agarwal@mayadata.io |     |
| rajaSahil  | sahil.raja@mayadata.io       |     |
| Sanjay1611 | sanjay.nathani@mayadata.io   |     |

## Get Repo Info

```console
helm repo add openebs-monitoring https://openebs.github.io/monitoring/
helm repo update
```

_See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation._

## Install Chart

Please visit the [link](https://openebs.github.io/monitoring/) for install instructions via helm3.

```console
# Helm
helm install [RELEASE_NAME] openebs-monitoring/openebs-monitoring --namespace [NAMESPACE] --create-namespace
```

_See [configuration](#configuration) below._

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

## Dependencies

By default this chart installs additional, dependent charts:

| Repository                                                                                 | Name                  | Version  |
| ------------------------------------------------------------------------------------------ | --------------------- | -------- |
| https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack | kube-prometheus-stack | `15.4.*` |

_See [helm dependency](https://helm.sh/docs/helm/helm_dependency/) for command documentation._

## Uninstall Chart

```console
# Helm
helm uninstall [RELEASE_NAME] --namespace [NAMESPACE]
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

## Upgrading Chart

```console
# Helm
helm upgrade [RELEASE_NAME] [CHART] --install --namespace [NAMESPACE]
```

## Configuration

The following table lists the configurable parameters of the OpenEBS monitoring chart and their default values.

You can modify different parameters by specifying the desired value in the `helm install` command by using the `--set` and/or the `--set-string` flag(s). You can modify the parameters of the [kube-prometheus-stack chart](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) by adding `kube-prometheus-stack` before the desired parameter in the `helm install` command.

In the following sample command we modify `serviceMonitors.cstor.enabled` from the openebs-monitoring chart and `kube-prometheus-stack.kubeProxy.enabled` from the kube-prometheus-stack chart to disable monitoring for cstor volumes and kube-proxy.

```console
helm install openebs-monitoring openebs-monitoring/monitoring --namespace openebs-monitoring --create-namespace \
	--set serviceMonitors.cstor.enabled=false \
	--set kube-prometheus-stack.kubeProxy.enabled=false
```

| Parameter                                                                                 | Description                                                                         | Default                                                   |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | --------------------------------------------------------- |
| `kube-prometheus-stack.prometheus.service.type`                                           | Service type for Prometheus                                                         | `"NodePort"`                                              |
| `kube-prometheus-stack.prometheus.service.nodePort`                                       | NodePort value for Prometheus service                                               | `32514`                                                   |
| `kube-prometheus-stack.prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues` | Enables Prometheus to select every service monitors                                 | `false`                                                   |
| `kube-prometheus-stack.prometheus.prometheusSpec.podMonitorSelectorNilUsesHelmValues`     | Enables Prometheus to select every pod monitors                                     | `false`                                                   |
| `kube-prometheus-stack.prometheus.prometheusSpec.ruleSelectorNilUsesHelmValues`           | Enables Prometheus to select every Prometheus rules                                 | `false`                                                   |
| `kube-prometheus-stack.prometheus.prometheusSpec.replicas`                                | Number of instances to deploy for a Prometheus deployment                           | `1`                                                       |
| `kube-prometheus-stack.prometheus.prometheusSpec.storageSpec`                             | Storage spec to specify how storage shall be used.                                  | `{}`                                                      |
| `kube-prometheus-stack.prometheus-node-exporter.securityContext`                          | Privilege and access control settings for node-exporter                             | `{...}`                                                   |
| `kube-prometheus-stack.prometheus-node-exporter.extraArgs`                                | Additional container arguments                                                      | `[...]`                                                   |
| `kube-prometheus-stack.alertmanager.enabled`                                              | Deploy Alertmanager                                                                 | `true`                                                    |
| `kube-prometheus-stack.alertmanager.config`                                               | Provide YAML to configure Alertmanager.                                             | `{...}`                                                   |
| `kube-prometheus-stack.alertmanager.service.type`                                         | Service type for Alertmanager                                                       | `"NodePort"`                                              |
| `kube-prometheus-stack.alertmanager.service.nodePort`                                     | NodePort value for Alertmanager service                                             | `30903`                                                   |
| `kube-prometheus-stack.alertmanager.alertmanagerSpec.replicas`                            | Number of instances to deploy for a Alertmanager deployment                         | `1`                                                       |
| `kube-prometheus-stack.alertmanager.alertmanagerSpec.storage`                             | Storage is the definition of how storage will be used by the Alertmanager instances | `{}`                                                      |
| `kube-prometheus-stack.prometheusOperator.enabled`                                        | Deploy Prometheus Operator                                                          | `true`                                                    |
| `kube-prometheus-stack.grafana.enabled`                                                   | Enables monitoring of Grafana itself                                                | `true`                                                    |
| `kube-prometheus-stack.grafana.grafana.ini`                                               | Append to Grafana's primary configuration                                           | `{panels: {disable_sanitize_html: true}}`                 |
| `kube-prometheus-stack.grafana.service.type`                                              | Service type for Grafana                                                            | `"NodePort"`                                              |
| `kube-prometheus-stack.grafana.service.nodePort`                                          | NodePort value for Grafana service                                                  | `32515`                                                   |
| `kube-prometheus-stack.grafana.defaultDashboardsEnabled`                                  | Deploys default dashboards                                                          | `true`                                                    |
| `kube-prometheus-stack.grafana.openebsDashboardsEnabled`                                  | Deploys custom OpenEBS dashboards                                                   | `true`                                                    |
| `kube-prometheus-stack.grafana.adminPassword`                                             | Administrator password for Grafana                                                  | `"admin"`                                                 |
| `kube-prometheus-stack.grafana.sidecar.dashboards.enabled`                                | Allows Grafana sidecar container to provision dashboards                            | `true`                                                    |
| `kube-prometheus-stack.grafana.sidecar.dashboards.label`                                  | Labels for configmaps to be collected by Grafana sidecars                           | `"grafana_dashboard"`                                     |
| `kube-prometheus-stack.grafana.plugins`                                                   | Adds Grafana plugin list to be installed                                            | `["grafana-polystat-panel","snuids-trafficlights-panel"]` |
| `openebsMonitoringAddon.cStor.enabled`                                                          | Enables installation of monitoring addons for cStor                      | `true`                                                    |
| `openebsMonitoringAddon.cStor.dashboards.enabled`                                                          | Enables dashboard installation of OpenEBS cStor Storage engine                      | `true`                                                    |
| `openebsMonitoringAddon.jiva.enabled`                                                          | Enables installation of monitoring addons for Jiva                      | `true`                                                    |
| `openebsMonitoringAddon.jiva.dashboards.enabled`                                                           | Enables dashboard installation of OpenEBS Jiva Storage engine                       | `true`                                                    |
| `openebsMonitoringAddon.localPV.enabled`                                                          | Enables installation of monitoring addons for localPV                      | `true`                                                    |
| `openebsMonitoringAddon.lvmLocalPV.enabled`                                                          | Enables installation of monitoring addons for lvm-LocalPV                      | `true`                                                    |
| `openebsMonitoringAddon.localPV.dashboards.enabled`                                                        | Enables dashboard installation of OpenEBS Local PV Storage engine                   | `true`                                                    |
| `openebsMonitoringAddon.lvmLocalPV.dashboards.enabled`                                                     | Enables dashboard installation of OpenEBS lvm-localpv storage engine                | `true`                                                    |
| `openebsMonitoringAddon.npd.dashboards.enabled`                                                            | Enables dashboard installation related to node problems                             | `true`                                                    |
| `openebsMonitoringAddon.ndm.dashboards.enabled`                                                            | Enables dashboard installation of OpenEBS node-disk-manager(NDM)                    | `true`                                                    |
| `node-problem-detector.extraVolumes`                                                      | Volumes needed by node problem detector                                             | `[...]`                                                   |
| `node-problem-detector.extraVolumeMounts`                                                 | Volumes mounts needed by node problem detector                                      | `[...]`                                                   |
| `node-problem-detector.metrics.serviceMonitor.enabled`                                    | Enables node problem detector monitoring                                            | `true`                                                    |
| `openebsMonitoringAddon.cStor.alertRules.enabled`                                                                | Enables OpenEBS pool and volume rules for cStor                                     | `true`                                                    |
| `openebsMonitoringAddon.jiva.alertRules.enabled`                                                                 | Enables OpenEBS volume rules for Jiva                                               | `true`                                                    |
| `openebsMonitoringAddon.lvmLocalPV.alertRules.enabled`                                                           | Enables OpenEBS lvm-localpv Storage engine rules                                    | `true`                                                    |
| `openebsMonitoringAddon.volume.alertRules.enabled`                                                              | Enables persistent volume rules                                                     | `true`                                                    |
| `openebsMonitoringAddon.cstor.serviceMonitor.enabled`                                                           | Enables monitoring of cStor volumes                                                 | `true`                                                    |
| `openebsMonitoringAddon.cstor.serviceMonitor.endpoints.port`                                                    | Name of the service port cstor volume endpoint refers to                            | `"exporter"`                                              |
| `openebsMonitoringAddon.cstor.serviceMonitor.endpoints.path`                                                    | HTTP path to scrape for metrics from cstor volume                                   | `"/metrics"`                                              |
| `openebsMonitoringAddon.cstor.serviceMonitor.relabelings`                                             | RelabelConfigs to apply to cstor volumes before scraping                            | `[...]`                                                   |
| `openebsMonitoringAddon.cstor.serviceMonitor.selector`                                                          | Selector to select endpoints objects                                                | `{matchLabels: {openebs.io/cas-type: cstor}}`             |
| `openebsMonitoringAddon.cstor.serviceMonitor.namespaceSelector`                                                 | Selector to select which namespaces the endpoints objects are discovered from       | `[any: true]`                                             |
| `openebsMonitoringAddon.jiva.serviceMonitor.enabled`                                                            | Enables monitoring of jiva volumes                                                  | `true`                                                    |
| `openebsMonitoringAddon.jiva.serviceMonitor.endpoints.port`                                                     | Name of the service port jiva volume endpoint refers to                             | `"exporter"`                                              |
| `openebsMonitoringAddon.jiva.serviceMonitor.endpoints.path`                                                     | HTTP path to scrape for metrics from jiva volume                                    | `"/metrics"`                                              |
| `openebsMonitoringAddon.jiva.serviceMonitor.endpoints.relabelings`                                              | RelabelConfigs to apply to jiva volumes before scraping                             | `[...]`                                                   |
| `openebsMonitoringAddon.jiva.serviceMonitor.selector`                                                           | Selector to select endpoints objects                                                | `{matchLabels: {openebs.io/cas-type: jiva}}`              |
| `openebsMonitoringAddon.jiva.serviceMonitor.namespaceSelector`                                                  | Selector to select which namespaces the endpoints objects are discovered from       | `[any: true]`                                             |
| `openebsMonitoringAddon.lvmLocalPV.serviceMonitor.enabled`                                                     | Enables monitoring of lvm localPV                                                   | `true`                                                    |
| `openebsMonitoringAddon.lvmLocalPV.serviceMonitor.endpoints.port`                                              | Name of the service port lvm localPV node endpoint refers to                        | `"metrics"`                                               |
| `openebsMonitoringAddon.lvmLocalPV.serviceMonitor.endpoints.path`                                              | HTTP path to scrape for metrics from lvm localPV node                               | `"/metrics"`                                              |
| `openebsMonitoringAddon.lvmLocalPV.serviceMonitor.selector`                                                    | Selector to select endpoints objects                                                | `{matchLabels: {name: openebs-lvm-node}}`                 |
| `openebsMonitoringAddon.lvmLocalPV.serviceMonitor.namespaceSelector`                                           | Selector to select which namespaces the endpoints objects are discovered from       | `[any: true]`                                             |
| `openebsMonitoringAddon.ndm.enabled`                                                          | Enables installation of monitoring addons for  OpenEBS ndm                      | `true`                                                    |
| `openebsMonitoringAddon.ndm.serviceMonitor.enabled`                                                             | Enables monitoring of OpenEBS ndm                                                   | `true`                                                    |
| `openebsMonitoringAddon.ndm.serviceMonitor.endpoints.port`                                                      | Name of the service port ndm exporters endpoint refers to                           | `"metrics"`                                               |
| `openebsMonitoringAddon.ndm.serviceMonitor.endpoints.path`                                                      | HTTP path to scrape for metrics from ndm exporters                                  | `"/metrics"`                                              |
| `openebsMonitoringAddon.ndm.serviceMonitor.selector`                                                            | Selector to select endpoints objects                                                | `{matchLabels: {name: openebs-ndm-exporter}}`             |
| `openebsMonitoringAddon.ndm.serviceMonitor.namespaceSelector`                                                   | Selector to select which namespaces the endpoints objects are discovered from       | `[any: true]`                                             |
| `openebsMonitoringAddon.deviceLocalPV.enabled`                                                          | Enables installation of monitoring addons for device-LocalPV                      | `true`                                                    |
| `openebsMonitoringAddon.deviceLocalPV.serviceMonitor.enabled`                                                  | Enables monitoring of device localPV                                                | `true`                                                    |
| `openebsMonitoringAddon.deviceLocalPV.serviceMonitor.endpoints.port`                                           | Name of the service port device localPV node endpoint refers to                     | `"metrics"`                                               |
| `openebsMonitoringAddon.deviceLocalPV.serviceMonitor.endpoints.path`                                           | HTTP path to scrape for metrics from device localPV node                            | `"/metrics"`                                              |
| `openebsMonitoringAddon.deviceLocalPV.serviceMonitor.selector`                                                 | Selector to select endpoints objects                                                | `{matchLabels: {name: openebs-device-node}}`              |
| `openebsMonitoringAddon.deviceLocalPV.serviceMonitor.namespaceSelector`                                        | Selector to select which namespaces the endpoints objects are discovered from       | `[any: true]`                                             |
| `openebsMonitoringAddon.cStor.podMonitor.enabled`                                                               | Enables monitoring of cStor pools                                                   | `true`                                                    |
| `openebsMonitoringAddon.cStor.podMonitor.podMetricsEndpoints.targetPort`                                        | Name or number of the cstor pool endpoint's target port                             | `9500`                                                    |
| `openebsMonitoringAddon.cStor.podMonitor.podMetricsEndpoints.path`                                              | HTTP path to scrape for metrics from cstor pool pod                                 | `"/metrics"`                                              |
| `openebsMonitoringAddon.cStor.podMonitor.podMetricsEndpoints.relabelings`                                       | RelabelConfigs to apply to cstor pools before scraping                              | `[...]`                                                   |
| `openebsMonitoringAddon.cStor.podMonitor.selector`                                                              | Selector to select endpoints objects                                                | `{matchLabels: {app: cstor-pool}}`                        |
| `openebsMonitoringAddon.cStor.podMonitor.namespaceSelector`                                                     | Selector to select which namespaces the endpoints objects are discovered from       | `[any: true]`                                             |
| `openebsMonitoringAddon.zfsLocalPV.enabled`                                                          | Enables installation of monitoring addons for zfs LocalPV                      | `true`                                                    |
| `openebsMonitoringAddon.zfsLocalPV.dashboards.enabled`                                                        | Enables dashboard installation of OpenEBS zfs localPV Storage engine                   | `true`                                                    |

We can edit the npd parameters too accordingly from [here](https://artifacthub.io/packages/helm/deliveryhero/node-problem-detector)

A YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
helm install <release-name> -f values.yaml --namespace openebs-monitoring openebs-monitoring/monitoring
```

> **Tip**: You can use the default [values.yaml](values.yaml)
