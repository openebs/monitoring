{
  // openebs-mixin configurations
  _config+:: {
    // dashboards configuration. If set, then dashboards json will be generated.
    dashboards: {
      cStor: true,
      Jiva: true,
      LocalPV: true,
    },
    // AlertRules configuration. If set, then rules json will be generated.
    alertRules: {
      cStor: true,
      Jiva: true,
      lvmLocalPV: false,
      volume: true,
    },
  },
}
