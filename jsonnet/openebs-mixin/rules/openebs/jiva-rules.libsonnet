// import jiva volume alert rules.
local jivaVolume = (import './jiva-volume-rules.libsonnet');

// Aggregate jiva volume alert rules in Jiva.
// JivaVolume -> Jiva
function(param) {
  local rules = self,
  _config+:: param,
  prometheusRules+:: {
    jiva: {
      [if rules._config.alertRules.jiva then 'groups']+:
        jivaVolume(rules._config).prometheusRules.jivaVolume.groups,
    },
  },
}
