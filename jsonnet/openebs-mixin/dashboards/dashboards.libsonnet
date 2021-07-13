function(param) {
  local dashboard = self,
  _config+:: param + dashboard,
  grafanaDashboards+:: {
    [if dashboard._config.dashboards.Jiva then 'jiva-volume.json']: import 'jiva-volume.json',
    [if dashboard._config.dashboards.cStor then 'cstor-overview.json']: import 'cstor-overview.json',
    [if dashboard._config.dashboards.cStor then 'cstor-volume.json']: import 'cstor-volume.json',
    [if dashboard._config.dashboards.cStor then 'cstor-volume-replica.json']: import 'cstor-volume-replica.json',
    [if dashboard._config.dashboards.cStor then 'cstor-pool.json']: import 'cstor-pool.json',
    [if dashboard._config.dashboards.LocalPV then 'localpv-workload.json']: import 'localpv-workload.json',
  },
}
