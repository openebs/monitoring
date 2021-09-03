## How to generate dashboards and alert rules for monitoring helm chart

To generate dashboards and alert rules for monitoring helm chart and release a new version of helm chart.

## Step by Step Process
1. Add [dashboards](dashboards.md) and [alerts rules](alerts.md) in openebs-mixin by following the documented steps.

2. Update the dashboards and rules folder in [build.sh](../jsonnet/openebs-mixin/build.sh). The auto generated json files will be inside this folder.  
   
   For example: If you add dashboards and alert rules for mayastor in openebs-mixin, then add mayastor as a folder name in build.sh file. 
   ```
	generateDashboards(){
		. . . 
		dashboardsFolder=(cStor jiva localPV npd lvmLocalPV ndm mayastor)
	    . . . 
	}

	generateRules(){
		. . . 
		rulesFolder=(cStor jiva volume npd lvmLocalPV mayastor)
	    . . . 
	}
	```
3. Run `make generate` to generate the dashboards and alert rules for the monitoring helm chart. 
   ```
   $ cd jsonnet/openebs-mixin
   $ make generate
   ```
   
4. Update [helm configurations](../deploy/charts/values.yaml).   
   
   For example: Add mayastor configuration in values.yaml with the following fields.
   ```
   . . . 
	openebsMonitoringAddon:
	  mayastor:
		enabled: true
    	dashboards:
    	  enabled: true
		alertRules:
      	  enabled: true
	. . .
	```
	
5. Update chart version in [chart.yaml](../deploy/charts/Chart.yaml)
   ```
   . . .
   version: 0.4.x
   . . .
   ```

---
**NOTE**

- To upgrade the depdendencies like kube-prometheus, do `jb update`. 
	```
	cd jsonnet
	jb update
	```

- To upgrade the dependencies like kube-prometheus-stack in helm chart, update its version in [chart.yaml](../deploy/charts/Chart.yaml)
	```
	. . . 
	dependencies:
	  - name: kube-prometheus-stack
	    version: "16.5.*"
	    . . .
	```
