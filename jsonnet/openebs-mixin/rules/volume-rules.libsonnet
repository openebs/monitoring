local volumePVC = (import 'volume-pvc-rules.libsonnet');
local volumeNode = (import 'volume-node-rules.libsonnet');

function(param) {
  local rules = self,
  _config+:: param,
  prometheusRules+:: {
    volume: {
      [if rules._config.alertRules.volume then 'groups']+: volumePVC(rules._config).prometheusRules.volumePVC.groups + volumeNode(rules._config).prometheusRules.volumeNode.groups,
    },
  },
}
