#  OpenEBS Monitoring

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
![Chart Lint and Test](https://github.com/openebs/monitoring/workflows/Chart%20Lint%20and%20Test/badge.svg)
![Release Charts](https://github.com/openebs/monitoring/workflows/Release%20Charts/badge.svg?branch=develop)

A Helm chart for openebs monitoring. This chart bootstraps OpenEBS monitoring stack on a [Kubernetes](http://kubernetes.io) cluster using the  
[Helm](https://helm.sh) package manager.


**Homepage:** <http://www.openebs.io/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| kiranmova | kiran.mova@mayadata.io |  |
| avishnu | vishnu.attur@mayadata.io |  |
| Ab-hishek | abhishek.agarwal@mayadata.io |  |
| rajaSahil | sahil.raja@mayadata.io |  |
| Sanjay1611 | sanjay.nathani@mayadata.io |  |


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

| Repository | Name | Version |
|------------|------|---------|
| https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack | kube-prometheus-stack | 15.4.* |

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

| Parameter                                                  | Description                                  | Default                            |
| ---------------------------------------------------------- | -------------------------------------------- | ---------------------------------- |
| `kube-prometheus-stack.prometheus.service.type`            | Service type for Prometheus                  | `"NodePort"`                       |
| `kube-prometheus-stack.prometheus.service.nodePort`        | NodePort value for Prometheus service        | `32514`                            |
| `kube-prometheus-stack.grafana.service.type`               | Service type for Grafana                     | `"NodePort"`                       |
| `kube-prometheus-stack.grafana.service.nodePort`           | NodePort value for Grafana service           | `32515`                            |
| `kube-prometheus-stack.prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues` | Enables prometheus to select every service monitors               | `false`                         |
| `kube-prometheus-stack.prometheus.prometheusSpec.podMonitorSelectorNilUsesHelmValues`     | Enables prometheus to select every pod monitors          | `false`                          |
| `kube-prometheus-stack.grafana.enabled`                    | Enables monitoring of grafana itself         | `true`                             |
| `kube-prometheus-stack.grafana.defaultDashboardsEnabled`   | Deploys default dashboards                   | `true`                             |
| `kube-prometheus-stack.grafana.customDashboardsEnabled`    | Deploys custom OpenEBS dashboards            | `true`                             |
| `kube-prometheus-stack.grafana.adminPassword`              | Administrator password for Grafana           | `"admin"`                          |
| `kube-prometheus-stack.grafana.sidecar.dashboards.enabled` | Allows grafana sidecar container to provision dashboards  | `true`                |
| `kube-prometheus-stack.grafana.sidecar.dashboards.label`   | Labels for configmaps to be collected by grafana sidecars | `"grafana_dashboard"` |
| `serviceMonitors.cstor.enabled`                            | Enables monitoring of cStor volumes          | `true`                             |
| `serviceMonitors.cstor.endpoints.ports`                    | Name of the service port cstor volume endpoint refers to  | `"exporter"`          |
| `serviceMonitors.cstor.endpoints.path`                     | HTTP path to scrape for metrics from cstor volume         | `"/metrics"`          |
| `serviceMonitors.cstor.endpoints.relabelings`              | RelabelConfigs to apply to cstor volumes before scraping  | `[...]`               |
| `serviceMonitors.cstor.selector`                           | Selector to select endpoints objects         | `{matchLabels: {openebs.io/cas-type: cstor}}`               |
| `serviceMonitors.cstor.namespaceSelector`                  | Selector to select which namespaces the endpoints objects are discovered from                        | `[any: true]`                         |
| `serviceMonitors.jiva.enabled`                             | Enables monitoring of jiva volumes           | `true`                             |
| `serviceMonitors.jiva.endpoints.ports`                     | Name of the service port jiva volume endpoint refers to  | `"exporter"`           |
| `serviceMonitors.jiva.endpoints.path`                      | HTTP path to scrape for metrics from jiva volume         | `"/metrics"`           |
| `serviceMonitors.jiva.endpoints.relabelings`               | RelabelConfigs to apply to jiva volumes before scraping  | `[...]`                |
| `serviceMonitors.jiva.selector`                            | Selector to select endpoints objects         | `{matchLabels: {openebs.io/cas-type: jiva}}`                |
| `serviceMonitors.jiva.namespaceSelector`                   | Selector to select which namespaces the endpoints objects are discovered from                        | `[any: true]`                         |
| `podMonitors.cstor.enabled`                                | Enables monitoring of cStor pools            | `true`                             |
| `podMonitors.cstor.podMetricsEndpoints.targetPort`         | Name or number of the cstor pool endpoint's target port    | `9500`               |
| `podMonitors.cstor.podMetricsEndpoints.path`               | HTTP path to scrape for metrics from cstor pool pod        | `"/metrics"`         |
| `podMonitors.cstor.podMetricsEndpoints.relabelings`        | RelabelConfigs to apply to cstor pools before scraping     | `[...]`              |
| `podMonitors.cstor.selector`                               | Selector to select endpoints objects                       | `{matchLabels: {app: cstor-pool}}`          |
| `podMonitors.cstor.namespaceSelector`                      | Selector to select which namespaces the endpoints objects are discovered from                        | `[any: true]`                         |

A YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
helm install <release-name> -f values.yaml --namespace openebs-monitoring openebs-monitoring/monitoring
```

> **Tip**: You can use the default [values.yaml](values.yaml)
