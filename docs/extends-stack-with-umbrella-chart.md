# Extending the monitoring stack

### Prerequisite

- Helm 3+ installed
- OpenEBS installed

# What is a umbrella chart and why use it ?

An umbrella chart is a way of encapsulate multiple complex charts with one chart.

>Many of the charts in the CNCF Artifact Hub are "building blocks" for creating more advanced applications. But charts may be used to create instances of large-scale applications. In such cases, a single umbrella chart may have multiple subcharts, each of which functions as a piece of the whole.

>The current best practice for composing a complex application from discrete parts is to create a top-level umbrella chart that exposes the global configurations, and then use the charts/ subdirectory to embed each of the components.   
Source: https://helm.sh/docs/howto/charts_tips_and_tricks/#complex-charts-with-many-dependencies

Using an umbrella chart will allow you customize OpenEBS monitoring stack settings without modifying that chart content.  It's also easier to update a dependency.

To create your our umbrella chart, you will have a create a folder structure like this.

```
📦umbrella
┣ 📜Chart.yaml
┗ 📜values.yaml
```

| File               | Description                                                                      |
| ------             | ------                                                                           |
| Chart.yaml         | Contains your chart identification with a dependency to OpenEBS monitoring stack |
| values.yaml        | Contains all your settings values                                                |

# Umbrella chart with ingress and storage enabled

Here a example that will enable ingress and storage for OpenEBS monitoring stack.

In the file **Chart.yaml**, you will enter your umbrella chart information with a dependency to OpenEBS monitoring stack.  The property name : `condition` is optional.  That property will allow you to install that dependency or not depending of the value in `values.yaml`.

#### Chart.yaml
````yaml
apiVersion: v2
name: monitoring-stack
description: Umbrella Chart for OpenEBS monitoring stack
icon: https://avatars.githubusercontent.com/u/20769039?s=200&v=4
type: application
version: 0.1.1
appVersion: 1.0.0
dependencies:
  - name: openebs-monitoring
    version: 0.4.8
    repository: "https://openebs.github.io/monitoring/"
    condition: openebs-monitoring.install
````

In the file **values.yaml**, you will define your configuration for the monitoring stack.

If you defined a **dependency condition** in **Chart.yaml**, you will have to define the value in that condition.  In this example, the condition name is `openebs-monitoring.install`.

if you provide only the condition value, you will deploy OpenEBS monitoring stack with the default values provided in there chart.

#### value.yaml (with default values)
````yaml
openebs-monitoring:
  install: true
````

#### value.yaml (with ingress and storage)

To use storage for the monitoring stack, you will have to create the storage class before using it.  In the following example, I use a storage class named: `sc-metrics` which already exists in my cluster.

Similarly you can also customize other parameters. For instance, if domain name has to be used to access the user interfaces, the `ingress` section needs to be updated. In the following example I use the value: `dev.dynamic.cluster109.local`.

The applications will be accessible from :
- http://dev.dynamic.cluster109.local/prometheus
- http://dev.dynamic.cluster109.local/grafana
- http://dev.dynamic.cluster109.local/alertmanager

Here the content of **values.yaml** with those settings.

````yaml
openebs-monitoring:
  install: true

  ## Configuration for kube-prometheus-stack subchart
  kube-prometheus-stack:
# PROMETHEUS SECTION
    prometheus:
      ingress:
        enabled: true
        annotations:
          nginx.ingress.kubernetes.io/ssl-redirect: "false"
        paths:
          - /prometheus(/|$)(.*)
        hosts:
          - dev.dynamic.cluster109.local

      prometheusSpec:
        ## Prefix used to register routes, overriding externalUrl route.
        ## Useful for proxies that rewrite URLs.
        ##
        routePrefix: /prometheus

        ## Prometheus StorageSpec for persistent data
        ## ref: https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/user-guides/storage.md
        ##
        storageSpec:
          volumeClaimTemplate:
            metadata:
              name: prom
            spec:
              storageClassName: sc-metrics
              accessModes: [ "ReadWriteOnce" ]
              resources:
                requests:
                  storage: 8Gi

# ALERTMANAGER SECTION
    alertmanager:
      ingress:
        enabled: true

        annotations:
          nginx.ingress.kubernetes.io/ssl-redirect: "false"
          nginx.ingress.kubernetes.io/rewrite-target: /$2
        paths:
          - /alertmanager(/|$)(.*)
        hosts:
          - dev.dynamic.cluster109.local

      alertmanagerSpec:
        ## Storage is the definition of how storage will be used by the Alertmanager instances.
        ## ref: https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/user-guides/storage.md
        ##
        storage:
          volumeClaimTemplate:
            metadata:
              name: alert
            spec:
              storageClassName: sc-metrics
              accessModes: [ "ReadWriteOnce" ]
              resources:
                requests:
                  storage: 8Gi

# GRAFANA SECTION
    grafana:
      ## In order to render HTML and Javascript in a text panel without being sanitized
      ## enable the `disable_sanitize_html` settings in Grafana ini file
      grafana.ini:
        ## If you have Ingress, you need to change the root_url to match ingress path
        server:
          root_url: http://localhost:3000/grafana

      ## Enable persistence using Persistent Volume Claims
      ## ref: http://kubernetes.io/docs/user-guide/persistent-volumes/
      ##
      persistence:
        type: pvc
        enabled: true
        storageClassName: sc-metrics
        accessModes:
          - ReadWriteOnce
        size: 10Gi

      ingress:
        ## If true, Grafana Ingress will be created
        ##
        enabled: true

        annotations:
          nginx.ingress.kubernetes.io/ssl-redirect: "false"
          nginx.ingress.kubernetes.io/rewrite-target: /$2
        path: /grafana(/|$)(.*)
        hosts:
          - dev.dynamic.cluster109.local

# NDP SECTION
  ## Configuration for node-problem-detector subchart
  node-problem-detector:
    install: true
````

# Add your Grafana Dashboards and Prometheus rules

OpenEBS monitoring stack come with Grafana dashboards and Prometheus rules, but it's possible to add your own by extending the monitoring stack.

In the monitoring stack, there is a folder named `dashboards` that contains Grafana dashboards and the folder `rules` contains Prometheus rules.  To extends the stack, we will have the folder structure based on the structure within the monitoring stack.

Our umbrella chart folder structure will look like that :

| Folder/File               | Description                                                                 |
| ------               | ------                                                                           |
| charts               | Contains your chart dependencies (auto-generated with helm)                      |
| dashboards           | Contains all your Grafana dashboards (json format)                               |
| rules                | Contains all your Prometheus rules (json or yaml format)                         |
| templates            | helm templates to include your dashboards and rules into OpenEBS monitoring stack|
| Chart.yaml           | Contains your chart identification with a dependency to OpenEBS monitoring stack |
| values.yaml          | Contains all your settings values                                                |

Here a example of umbrella chart using external Grafana dashboards and Prometheus rules.  You can separate your files with sub folders to simplify and regroup them.  The helm templates will check within the sub folders for files to import.

````
📦umbrella
 ┣ 📂charts
 ┃ ┗ 📜openebs-monitoring-0.4.9.tgz
 ┣ 📂dashboards
 ┃ ┣ 📂custom
 ┃ ┃ ┣ 📜k8s-persistence-volumes.json
 ┃ ┃ ┗ 📜node-exporter-full.json
 ┃ ┗ 📂kafka
 ┃ ┃ ┣ 📜confluent-open-source-grafana-dashboard.json
 ┣ 📂rules
 ┃ ┗ 📂custom
 ┃ ┃ ┗ 📜instance-down.json
 ┣ 📂templates
 ┃ ┣ 📜dashboards-json-configmap.yaml
 ┃ ┣ 📜prometheusRules.yaml
 ┃ ┗ 📜_helpers.tpl
 ┣ 📜Chart.lock
 ┣ 📜Chart.yaml
 ┗ 📜values.yaml
````

### Helm templates to import your files into OpenEBS monitoring stack

Here the content of the files into templates folder.  Those files are based on those within the monitoring stack.  You can customize it to fit your needs or use it as is. 

| File                            | Description                                                                |
| ------                          | ------                                                                     |
| _helpers.tpl                    | Helm template helper                                                       |
| dashboard-json-configmap.yaml   | Contains the logic to add Grafana dashboards to OpenEBS monitoring stack   |
| prometheusRules.yaml            | Contains the logic to add Prometheus rules to OpenEBS monitoring stack     |

#### _helpers.tpl
````yaml
{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "openebs-monitoring.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 50 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "openebs-monitoring.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 26 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 26 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 26 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts
*/}}
{{- define "openebs-monitoring.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "openebs-monitoring.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "openebs-monitoring.labels" -}}
helm.sh/chart: {{ include "openebs-monitoring.chart" . }}
{{ include "openebs-monitoring.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "openebs-monitoring.selectorLabels" -}}
app.kubernetes.io/name: {{ include "openebs-monitoring.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
release: {{ $.Release.Name | quote }}
{{- end }}

{{/*
Template to support multiple levels of sub-charts

Call a template from the context of a subchart.

Usage:
  {{ include "call-nested" (list . "<subchart_name>" "<subchart_template_name>") }}
*/}}
{{- define "call-nested" }}
{{- $dot := index . 0 }}
{{- $subchart := index . 1 | splitList "." }}
{{- $template := index . 2 }}
{{- $values := $dot.Values }}
{{- range $subchart }}
{{- $values = index $values . }}
{{- end }}
{{- include $template (dict "Chart" (dict "Name" (last $subchart)) "Values" $values "Release" $dot.Release "Capabilities" $dot.Capabilities) }}
{{- end }}
````

#### dashboard-json-configmap.yaml
````yaml
{{- $grafanaSidecarDashboardsLabel := index .Values "openebs-monitoring" "kube-prometheus-stack" "grafana" "sidecar" "dashboards" "label" }}
{{- $files := .Files.Glob "dashboards/**.json" }}
{{- if $files }}
{{- range $fileName, $fileContents := $files }}
{{- $dashboardName := regexReplaceAll "(^.*/)(.*)\\.json$" $fileName "${2}" }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ lower (printf "%s-%s" (include "openebs-monitoring.fullname" $) $dashboardName) | trunc 63 | trimSuffix "-" }}
  namespace: {{ template "openebs-monitoring.namespace" $ }}
  labels:
    {{ $grafanaSidecarDashboardsLabel }}: "1"
    app: {{ template "openebs-monitoring.name" $ }}-grafana
{{ include "openebs-monitoring.labels" $ | indent 4 }}
data:
  {{ $dashboardName }}.json: {{ $.Files.Get $fileName | toPrettyJson }}
---
{{- end }}
{{- end }}
````

#### prometheusRules.yaml
````yaml
{{- $files := .Files.Glob "rules/**.json" }}
  {{- if $files }}
  {{- range $fileName, $fileContents := $files }}
  {{- $ruleName := regexReplaceAll "(^.*/)(.*)\\.json$" $fileName "${2}" }}
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: {{ lower (printf "%s-%s" (include "openebs-monitoring.name" $) $ruleName) | trunc 63 | trimSuffix "-" }}
namespace: {{ template "openebs-monitoring.namespace" $ }}
labels:
  app: {{ template "openebs-monitoring.name" $ }}
  {{ include "openebs-monitoring.labels" $ | indent 4 }}
spec:
  {{ $.Files.Get $fileName | indent 2 }}
---
{{- end }}
  {{- end }}
````

Here a example of a custom Prometheus rules that you can add to the monitoring stack.

#### instance-down.json
````json
{
  "groups": [
    {
      "name": "Instances",
      "rules": [
        {
          "alert": "InstanceDown",
          "expr": "up == 0",
          "for": "10s",
          "labels": {
            "severity": "page"
          },
          "annotations": {
            "description": "{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 1 minute.",
            "summary": "Instance {{ $labels.instance }} down"
          }
        }
      ]
    }
  ]
}
````

# How to deploy the umbrella chart

### Download the dependencies
The first step will be to download the dependencies by running this command in a terminal in the umbrella folder.

````console
helm dep build
````

If you had already ran that command and you changed the dependencies in Chart.yaml, you will have to download the new dependencies by running this command.

````console
helm dep up
````

You will obtain that folder structure

```
📦umbrella
 ┣ 📂charts
 ┃ ┗ 📜openebs-monitoring-0.4.8.tgz
 ┣ 📂templates
 ┣ 📜Chart.lock
 ┣ 📜Chart.yaml
 ┗ 📜values.yaml
```

### Install the chart

#### From the umbrella folder

In a terminal in the umbrella folder run this command :

```console
helm install [RELEASE_NAME] . -n  [NAMESPACE] --create-namespace
```

ex :
````console
helm install monitoring . -n monitoring --create-namespace
````

#### From a helm chart repository

In a terminal in the umbrella folder run this command :

```console
helm install [RELEASE_NAME] [REPOSITORY]/[CHART_NAME] -n  [NAMESPACE]  --create-namespace
```

ex :
````console
helm install monitoring chartmuseum/monitoring-stack -n monitoring --create-namespace
````
