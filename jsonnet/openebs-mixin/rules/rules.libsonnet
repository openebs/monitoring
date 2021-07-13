local cstor = (import 'cstor-rules.libsonnet');
local jiva = (import 'jiva-rules.libsonnet');
local localpv = (import 'volume-rules.libsonnet');

function(param) {
  local prometheusRules = self,
  _config+:: param,
  prometheusRules+::
    cstor(prometheusRules._config).prometheusRules + jiva(prometheusRules._config).prometheusRules + localpv(prometheusRules._config).prometheusRules,
}
