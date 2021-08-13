## How to add new dashboards in openebs-mixin.
To add new dashboard in openebs-mixin, you need to add dashboard json file in [dashboards](jsonnet/../../jsonnet/openebs-mixin/dashboards/) directory and import it through [dashboards.libsonnet](../jsonnet/openebs-mixin/dashboards/dashboards.libsonnet) to create grafanaDashboards object.

## Step by Step Process
1. Add dashboards json in [dashboards](jsonnet/../../jsonnet/openebs-mixin/dashboards/) directory.
2. Add configuration in [config.libsonnet](../jsonnet/openebs-mixin/config.libsonnet) to allow users to configure dashboard. For example:
	```
	. . . 
	// dashboards configuration. If set, then dashboards are included in grafanaDashboards object.
	dashboards: {
		newDashboard: true # to import dashboard as grafanaDashboards object
	},
	. . .
	```
3. Import the dashboard json in [dashboards.libsonnet](../jsonnet/openebs-mixin/dashboards/dashboards.libsonnet) to include it in `grafanaDashboards` object.    
	```
	. . .
	grafanaDashboards+:: {
		. . .
		[if dashboard._config.dashboards.newDashboard then 'new-dashboard.json']: import './new-dashboard.json',
	},
	. . .
	```