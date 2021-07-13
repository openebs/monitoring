local jivaVolume = (import './jiva-volume-rules.libsonnet');
function(param) {
  local rules = self,
  _config+:: param,
  prometheusRules+:: {
    Jiva: {
      [if rules._config.alertRules.Jiva then 'groups']+:
        jivaVolume(rules._config).prometheusRules.JivaVolume.groups,
    },
  },
}
