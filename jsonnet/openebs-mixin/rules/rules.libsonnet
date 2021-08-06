local cstor = (import './openebs/cstor-rules.libsonnet');
local jiva = (import './openebs/jiva-rules.libsonnet');
local lvmLocalPV = (import './openebs/lvmlocalpv-rules.libsonnet');
local volume = (import './volume/volume-rules.libsonnet');
local npd = (import './npd/npd-rules.libsonnet');

// Alert rules for different CAS types and others(as defined in config.libsonnet under alertRules) are stored separately in prometheusRules object.
// prometheusRules : {
//    cStor:{
//      groups:[
//        {alert-1},
//        {alert-2}
//          .
//          .
//        {alert-n}
//        ]
//    },
//    Jiva: {
//      ...
//    },
//      ...
//    }

function(param) {
  local prometheusRules = self,
  _config+:: param,
  prometheusRules+::
    cstor(prometheusRules._config).prometheusRules + jiva(prometheusRules._config).prometheusRules + lvmLocalPV(prometheusRules._config).prometheusRules + volume(prometheusRules._config).prometheusRules
    + npd(prometheusRules._config).prometheusRules,
}
