local prometheusRules = (import '../config.libsonnet').openebsMixin.rules;
local utils = import '../lib/utils.libsonnet';
local config = import '../config.libsonnet';

{
  // PrometheusRule yamls for different cas types
  prometheusRules:
    {
      [if config.openebsMixin._config.alertRules[monitoringAddon] then monitoringAddon]:

        utils.PrometheusRule(std.asciiLower(monitoringAddon)) {
          spec+: {
            groups: prometheusRules[monitoringAddon].groups,
          },
        }

      for monitoringAddon in std.objectFields(config._config.openebsMonitoringAddon)

    } +
    { [if config.openebsMixin._config.alertRules.volume then 'volume']:

      utils.PrometheusRule(std.asciiLower('volume')) {
        spec+: {
          groups: prometheusRules.volume.groups,
        },
      } },
}
