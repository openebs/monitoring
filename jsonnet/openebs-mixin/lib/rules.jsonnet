local rules = (import '../mixin.libsonnet');
local config = import '../config.libsonnet';

{
  [if config._config.alertRules[name] then std.asciiLower(name) + '-rules.json']: rules.prometheusRules[name]
  for name in std.objectFields(config._config.alertRules)
}
