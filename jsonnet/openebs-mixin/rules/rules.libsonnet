local cstor = (import 'cstor-rules.libsonnet');
local jiva = (import 'jiva-rules.libsonnet');
local volume = (import 'volume-rules.libsonnet');
local npd = (import 'npd-rules.libsonnet');

// Populate prometheusRules object from cstor, jiva and volume rules.
function(param) {
  local prometheusRules = self,
  _config+:: param,
  prometheusRules+::
    cstor(prometheusRules._config).prometheusRules + jiva(prometheusRules._config).prometheusRules + volume(prometheusRules._config).prometheusRules
    + npd(prometheusRules._config).prometheusRules,
}
