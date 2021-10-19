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

####value.yaml (with default values)
````yaml
openebs-monitoring:
  install: true
````

#### value.yaml (with ingress and storage)

To use storage for the monitoring stack, you will have to create the storage class before using it.  In this example, I use a storage class named : `sc-metrics`.

For ingress, I used a domain name : `dev.dynamic.cluster109.local`

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
