local config = import '../config.libsonnet';
local oc = import '../lib/utils.libsonnet';

{
  // PodMonitor yamls for different cas types
  podMonitors:
    {
      [if config._config.openebsMonitoringAddon[monitoringAddon].enabled && config._config.openebsMonitoringAddon[monitoringAddon].podMonitor.enabled then monitoringAddon]:
        oc.PodMonitor(std.asciiLower(monitoringAddon), monitoringAddon)
      for monitoringAddon in std.objectFields(config._config.openebsMonitoringAddon)
    },
}
