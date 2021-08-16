local prometheusRules = (import '../config.libsonnet').openebsMixin.rules;
local utils = import '../lib/utils.libsonnet';
local config = import '../config.libsonnet';

{
  // PrometheusRule yamls for different cas types
  prometheusRules:
    {
      [if config.openebsMixin._config.alertRules[casType] then casType]:

        utils.PrometheusRule(std.asciiLower(casType)) {
          spec+: {
            groups: prometheusRules[casType].groups,
          },
        }

      for casType in std.objectFields(config._config.casType)

    } +
    { [if config.openebsMixin._config.alertRules.volume then 'volume']:

      utils.PrometheusRule(std.asciiLower('volume')) {
        spec+: {
          groups: prometheusRules.volume.groups,
        },
      } },
}
