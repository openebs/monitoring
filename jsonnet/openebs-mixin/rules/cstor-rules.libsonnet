local cstorPool = (import './cstor-pool-rules.libsonnet');
local cstorVolume = (import './cstor-volume-rules.libsonnet');


function(param) {
  local rules = self,
  _config+:: param,
  prometheusRules+:: {
    cStor: {
      [if rules._config.alertRules.cStor then 'groups']+: cstorPool(rules._config).prometheusRules.cStorPool.groups + cstorVolume(rules._config).prometheusRules.cStorVolume.groups,
    },
  },
}
