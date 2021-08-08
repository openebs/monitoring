# Install openebs-mixin

---
### Different scenarios to use openebs-mixin

1. Install openebs-mixin with openebs-monitoring written in jsonnet.
2. Install openebs-mixin in existing prometheus stack.

---  
## Install openebs-mixin with openebs-monitoring written in jsonnet.

### Prerequisite

- OpenEBS installed

#### Step by Step Process

1. **Configuration**  
   The available fields and their default values are present in [config.libsonnet](../jsonnet/config.libsonnet). To update the configuration of mixin, you need to override the configuration through config.libsonnet.
	```
   . . .
	// import openebs-mixin and override configurations
	openebsMixin: (import './openebs-mixin/mixin.libsonnet') {
		_config+:: {
			dashboards+: {
				cStor: $._config.casType.cStor.dashboards,
				jiva: $._config.casType.jiva.dashboards,
				localPV: $._config.casType.lvmLocalPV.dashboards,
				lvmLocalPV: $._config.casType.lvmLocalPV.dashboards,
				deviceLocalPV: $._config.casType.lvmLocalPV.dashboards,
			},
			alertRules+: {
				cStor: $._config.casType.cStor.alertRules,
				jiva: $._config.casType.jiva.alertRules,
				lvmLocalPV: $._config.casType.lvmLocalPV.alertRules,
				deviceLocalPV: $._config.casType.lvmLocalPV.alertRules,
			},
		},
	},
  	. . .

	```  

2. **Install openebs-monitoring**  
   To generate manifest to install openebs-monitoring in kubernetes cluster, you need to run [main.libsonnet](../jsonnet/main.jsonnet). To generate manifests, please follow the steps listed over [here](../jsonnet/README.md).  
    ```
    . . .
    local config = import './config.libsonnet';
    local openebsMixin = config.openebsMixin; 
    
    local kp =
        config.kp {
        	values+:: {
        	    grafana+: {
        		    dashboards+: openebsMixin.grafanaDashboards,
        	},
        };
    
    . . .
    
    // servicemonitor, podmonitor and prometheusrules for different casTypes of openebs
    { ['openebs-addons/openebs-servicemonitor-' + casType]: serviceMonitor.serviceMonitors[casType] for casType in std.objectFields(serviceMonitor.serviceMonitors) } +
    { ['openebs-addons/openebs-podmonitor-' + casType]: podMonitors.podMonitors[casType] for casType in std.objectFields(podMonitors.podMonitors) } +
    // to enable alert rules
    { ['openebs-addons/openebs-rule-' + name]: rules.prometheusRules[name] for name in std.objectFields(rules.prometheusRules) }
    . . .
    ```
	---  
	
## Install openebs-mixin in existing prometheus stack.  

### Prerequisite

- OpenEBS installed
- Prometheus stack installed
- ServiceMonitors and PodMonitors are already installed for different cas types.

#### Step by Step Process

1. **Override openebs-mixin configuration**    
	The available fields and their default values are present in [config.libsonnet](../jsonnet/openebs-mixin/config.libsonnet). To update the configuration of mixin, you need to override the configuration. 
   ```
   	. . .
	// import openebs-mixin and override configurations
	local openebsMixin=(import 'kube-prometheus/lib/mixin.libsonnet')({
	    name: 'openebsMixin',
		mixin: (import './openebs-mixin/mixin.libsonnet'){
		    _config+:: {
    			dashboards+: {
    				cStor: true,
    				jiva: false,
    				. . .
    			},
    			alertRules+: {
    				cStor: true,
    				jiva: true,
    				. . .
    			},
    		}
		},
	});
  	. . .
	```  
2. **Install openebs-mixin**  
   To create a openebs-mixin object that has Prometheus rules and Grafana dashboards:
	```
	local openebsMixin=(import 'kube-prometheus/lib/mixin.libsonnet')({
	    name: 'openebsMixin',
		mixin: (import './openebs-mixin/mixin.libsonnet'),
	});
	```
	The externalMixin object will have two objects - `prometheusRules` and `grafanaDashboards`. The `grafanaDashboards` object will be needed to be added to the dashboards field as in the example below:
	```
	. . .
	values+:: {
      grafana+: {
        // To install openebs dashboards
        dashboards+: externalMixin.grafanaDashboards,
      },
	}
	. . .
	```
	The `prometheusRules` object should be defined as its own jsonnet object.
	```
	. . .
	// To generate prometheusRule object 
	{ 'openebs-addons/openebs-mixin-prometheus-rules': openebsMixin.prometheusRules } 
	. . .
	```