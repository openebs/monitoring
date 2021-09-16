// Populate grafanaDashboards object
function(param) {
  local dashboard = self,
  _config+:: param,
  grafanaDashboards+:: {
    [if dashboard._config.dashboards.jiva then 'jiva-volume.json']: import './openebs/jiva-volume.json',
    [if dashboard._config.dashboards.cStor then 'cstor-overview.json']: import './openebs/cstor-overview.json',
    [if dashboard._config.dashboards.cStor then 'cstor-volume.json']: import './openebs/cstor-volume.json',
    [if dashboard._config.dashboards.cStor then 'cstor-volume-replica.json']: import './openebs/cstor-volume-replica.json',
    [if dashboard._config.dashboards.cStor then 'cstor-pool.json']: import './openebs/cstor-pool.json',
    [if dashboard._config.dashboards.localPV then 'localpv-workload.json']: import './openebs/localpv-workload.json',
    [if dashboard._config.dashboards.lvmLocalPV then 'lvmlocalpv-pool.json']: import './openebs/lvmlocalpv-pool.json',
    [if dashboard._config.dashboards.zfsLocalPV then 'zfslocalpv.json']: import './openebs/zfslocalpv.json',
    [if dashboard._config.dashboards.npd then 'npd-node-volume-problem.json']: import './npd/npd-node-volume-problem.json',
    [if dashboard._config.dashboards.ndm then 'ndm.json']: import './openebs/ndm.json',
  },
}
