local config = import '../config.libsonnet';
local oc = import '../lib/utils.libsonnet';

{
  // ServiceMonitor yamls for different cas types
  serviceMonitors:
    {
      [if config._config.openebsMonitoringAddon[monitoringAddon].enabled && config._config.openebsMonitoringAddon[monitoringAddon].serviceMonitor.enabled then monitoringAddon]:
        oc.ServiceMonitor(std.asciiLower(monitoringAddon), monitoringAddon)
      for monitoringAddon in std.objectFields(config._config.openebsMonitoringAddon)
    },
}
