local config = import '../config.libsonnet';
local oc = import '../lib/utils.libsonnet';

{
  // ServiceMonitor yamls for different cas types
  serviceMonitors:
    {
      [if config._config.casType[casType].enabled && config._config.casType[casType].serviceMonitor.enabled then casType]:
        oc.ServiceMonitor(std.asciiLower(casType), casType)
      for casType in std.objectFields(config._config.casType)
    },
}
