local rules = (import '../mixin.libsonnet');
local config = import '../config.libsonnet';

{
  // To generate rules json
  [if config._config.alertRules[name] then std.asciiLower(name) + '-rules.json']: rules.rules[name]
  for name in std.objectFields(config._config.alertRules)
}
