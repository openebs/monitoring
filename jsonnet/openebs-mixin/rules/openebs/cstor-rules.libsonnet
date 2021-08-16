// import all the alert rules for cstor pool and volumes
local cstorPool = (import './cstor-pool-rules.libsonnet');
local cstorVolume = (import './cstor-volume-rules.libsonnet');

// Aggregate cstor pool and volume alert rules in cstor.
// cstorPool alert rules + cstorVolume alert rules -> cstor.
function(param) {
  local rules = self,
  _config+:: param,
  prometheusRules+:: {
    cStor: {
      [if rules._config.alertRules.cStor then 'groups']+: cstorPool(rules._config).prometheusRules.cStorPool.groups + cstorVolume(rules._config).prometheusRules.cStorVolume.groups,
    },
  },
}
