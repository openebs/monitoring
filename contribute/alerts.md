## How to add new alerts in openebs-mixin.
To add new alert rules in openebs-mixin, you need to add alert rules in [rules](jsonnet/../../jsonnet/openebs-mixin/rules/) directory and import it through [rules.libsonnet](../jsonnet/openebs-mixin/dashboards/dashboards.libsonnet)and [prometheus-rules.libsonnet](../jsonnet/openebs-mixin/rules/prometheus-rules.libsonnet) to include it in prometheusRules object.

## Step by Step Process
1. Add alert rules in [rules](jsonnet/../../jsonnet/openebs-mixin/rules/) directory.
   - **new-alert-rules.libsonnet**
		```
		function(param) {
			//local rules = self,
			_config+:: param,
			prometheusRules+:: {
				npd: {
					groups+: [
					{
						name: 'volume-node',
						rules: [
							{
								alert-rule 1
							}
							. . .
						]
					}]
				}
			}
		};
		```

2. Add configuration in [config.libsonnet](../jsonnet/openebs-mixin/config.libsonnet) to allow users to configure alert rules. For example:
	```
	. . . 
	// // AlertRules configuration. If set, then alert rules are included in the prometheusRules object.
	alertRules: {
		newAlertRules: true # to include alert rules in prometheusRules object
	},
	. . .
	```
3. Import the alert rules in [rules.libsonnet](../jsonnet/openebs-mixin/dashboards/dashboards.libsonnet) and [prometheus-rules.libsonnet](../jsonnet/openebs-mixin/rules/prometheus-rules.libsonnet) and include it in `prometheusRules` object.
   Examples: 
   - [**prometheus-rules.libsonnet**](../jsonnet/openebs-mixin/rules/prometheus-rules.libsonnet)
		```
		. . .
		local newAlertRules = (import './new-alert-rules.libsonnet');

		prometheusRules+::
			. . .
			+ newAlertRules(prometheusRules._config).prometheusRules.newAlertRules,
		. . .
		```
	- [**rules.libsonnet**](../jsonnet/openebs-mixin/dashboards/dashboards.libsonnet)
		```
		. . .
		local newAlertRules = (import './new-alert-rules.libsonnet');

		prometheusRules+::
			. . .
			+ newAlertRules(prometheusRules._config).prometheusRules.newAlertRules.groups,
		. . .
		```