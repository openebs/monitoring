# Install openebs-addon-only

### Prerequisite

- Already installed prometheus-operator stack
- OpenEBS installed

---
**NOTE**

- To allow Prometheus to discover all `PodMonitors/ServiceMonitors`, without applying label filtering, you have to set `prometheus.prometheusSpec.podMonitorSelectorNilUsesHelmValues` and `prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues` to `false`  

- Install grafana plugin
   
   -   There are two plugins that we are using for OpenEBS dashboards.
  
       -  [grafana-polystat-panel]([https://link](https://grafana.com/grafana/plugins/grafana-polystat-panel/))

       -  [snuids-trafficlights-panel]([https://link](https://grafana.com/grafana/plugins/snuids-trafficlights-panel/))
       
   -   To install these plugin, exec into the `grafana` container  and run
		```
		grafana-cli plugins install grafana-polystat-panel 
		grafana-cli plugins install snuids-trafficlights-panel
		```
- Update Grafana configuration
   
   - Append the below configuration in the configmap in which Grafana initialisation is done or cm in which `grafana.ini` file is declared.
		```console
		grafana.ini:
		--------------
		...
		[panels]
		disable_sanitize_html = true
		...
		```

---

## Step by Step Process

1. **Update values.yaml**
   
   -  Disable dependent chart(kube-prometheus-stack) by updating `kube-prometheus-stack.install` to `false`
   -  If you have updated the label for Grafana sidecar container(`grafana-sc-dashboard`), then update `kube-prometheus-stack.grafana.sidecar.dashboards.label: <UPDATED_LABEL>`
   -  Update `namespaceOverride` with the namespace name in which Prometheus stack is installed
   -  After updating these specific values in values.yaml, these fields should look like this(example) :
		```console
		...
		namespaceOverride: "prometheus-operator"
		kube-prometheus-stack:
  		install: false
		  grafana:
		    ## Sidecar container to load dashboard cm
		    sidecar:
			  dashboards:
			  enabled: true
			  # ConfigMaps with label below will be added to Grafana as dashboards.
			  label: grafana_dashboard


		...
		```


2. **Install `openebs-monitoring` chart**
   
	```console
	# Helm
	helm install -f values.yaml [RELEASE_NAME] openebs-monitoring/openebs-monitoring
	```

#### Helm Chart install with one line

```console
#Helm
helm install [RELEASE_NAME] openebs-monitoring/openebs-monitoring -n  [PROMETHEUS-STACK-NAMESPACE]  --set kube-prometheus-stack.install=false,kube-prometheus-stack.grafana.sidecar.dashboards.label=[UPDATED_LABEL]
```

#### Verification

-  Verify `PodMonitors/ServiceMonitors` are installed

	```console
	kubectl get servicemonitors -n prometheus-operator -l  release="openebs-monitoring"                
	NAME                              AGE
	openebs-monitoring-openebs-cstor   33m
	openebs-monitoring-openebs-jiva    33m
	```

-  Verify `dashboards configmaps` are installed
 
    ```console
	kubectl get cm -n prometheus-operator -l release="openebs-monitoring"
	NAME                                                           DATA   AGE
	openebs-monitoring-openebs-cstor-pool                           1      37m
	```

- To see the dashboards, form the Grafana URL and open it in the browser

