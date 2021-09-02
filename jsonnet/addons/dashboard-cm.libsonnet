local dashboards = (import '../config.libsonnet').openebsMixin.grafanaDashboards;
local utils = import '../lib/utils.libsonnet';
local config = import '../config.libsonnet';


{
  // dashboards configMap yamls for different cas types.
  grafanaDashboards: {

    [if config._config.openebsMonitoringAddon[monitoringAddon].enabled && config._config.openebsMonitoringAddon[monitoringAddon].installDashboards then name]:

      utils.ConfigMap('grafana-dashboard-' + std.asciiLower(std.strReplace(name, '.json', ''))) {
        data: { [name]: std.manifestJson(dashboards[monitoringAddon][name]) },

      }

    for monitoringAddon in std.objectFields(config._config.openebsMonitoringAddon)
    for name in std.objectFields(dashboards[monitoringAddon])
  },
}
