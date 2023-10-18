local cstor = (import './openebs/cstor-rules.libsonnet');
local jiva = (import './openebs/jiva-rules.libsonnet');
local lvmLocalPV = (import './openebs/lvmlocalpv-rules.libsonnet');
local volume = (import './volume/volume-rules.libsonnet');
local npd = (import './npd/npd-rules.libsonnet');

// Populate prometheusRules object from cstor, jiva, volume and npd rules.
// prometheusRules:{
//     groups:[
//            {cStor alert-1},
//            {cStor alert-2}
//             .
//             .
//            {cStor alert-n},
//            {Jiva alert-1},
//             .
//            {Jiva alert-n},
//             ...
//        ]
//   },

function(param) {
  local prometheusRules = self,
  _config+:: param,
  prometheusRules+::
    cstor(prometheusRules._config).prometheusRules.cStor + jiva(prometheusRules._config).prometheusRules.jiva + lvmLocalPV(prometheusRules._config).prometheusRules.lvmLocalPV + volume(prometheusRules._config).prometheusRules.volume
    + npd(prometheusRules._config).prometheusRules.npd,
}
