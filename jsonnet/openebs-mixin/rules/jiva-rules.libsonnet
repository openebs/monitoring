local jivaVolume = (import './jiva-volume-rules.libsonnet');
function(param) {
  local rules = self,
  _config+:: param,
  prometheusRules+:: {
    Jiva: {
      groups+:
        jivaVolume(rules._config).prometheusRules.JivaVolume.groups,
    },
  },
}
