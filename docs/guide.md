# Install openebs-monitoring with custom Prometheus stack

### Prerequisite

- Already installed prometheus-operator stack
- OpenEBS installed

---
**NOTE**

To allow Prometheus to discover all `PodMonitors/ServiceMonitors`, without applying label filtering, you have to set `prometheus.prometheusSpec.podMonitorSelectorNilUsesHelmValues` and `prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues` to `false`

---

## Step by Step Process

1. **Update values.yaml**
   
   -  Disable dependent chart(kube-prometheus-stack) by updating `kube-prometheus-stack.enabled` to `false`
   -  Set `customPrometheusStack.enabled` to `true` 
   -  If you have updated the label for grafana sidecar container(`grafana-sc-dashboard`), then update `customPrometheusStack.grafana.sidecar.dashboards.label: <UPDATED_LABEL>`
   -  Update `namespaceOverride` with the namespace name in which prometheus stack is installed
   -  After updating these specific values in values.yaml, these fields should look like this(example) :
		```console
		...
		namespaceOverride: "prometheus-operator"
		customMonitoringStack:
		enabled: true
		grafana:
		  ## Deploy custom openebs dashboards
		  customDashboardsEnabled: true
		  ## Sidecar container to load dashboard cm
		  sidecar:
		    dashboards:
			  enabled: true
			  # ConfigMaps with label below will be added to Grafana as dashboards.
			  label: grafana_dashboard

		kube-prometheus-stack:
		  enabled: false
		...
		```

2. **Install grafana plugin**
   
   -   There are two plugins that we are using for openEBS dashboards.
  
       -  [grafana-polystat-panel]([https://link](https://grafana.com/grafana/plugins/grafana-polystat-panel/))

       -  [snuids-trafficlights-panel]([https://link](https://grafana.com/grafana/plugins/snuids-trafficlights-panel/))
       
    -  To install these plugin, exec into the `grafana` container  and run
		```
		grafana-cli plugins install grafana-polystat-panel 
		grafana-cli plugins install snuids-trafficlights-panel
		```
3. **Update `kube-state-metrics` label**
   
   - If servicemonitor for kube-state-metrics is installed, then append the below configuration in `spec.enpoints`
		```console
		endpoints:
        -  relabelings:
		   - action: labelmap
		   regex: __meta_kubernetes_pod_label_(.+)
		```


4. **Install `openebs-monitoring` chart**
   
	```console
	# Helm
	helm install -f values.yaml [RELEASE_NAME] openebs-monitoring/openebs-monitoring
	```


#### Verification

-  Verify `PodMonitors/ServiceMonitors` are installed

	```console
