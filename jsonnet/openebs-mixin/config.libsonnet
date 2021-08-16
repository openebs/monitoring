{
  // openebs-mixin configurations
  _config+:: {
    // Configuration to set which cas types is installed. Based on this, dashboards and alert rules configuration will be set.
    casTypes: {
      cStor: true,
      jiva: true,
      lvmLocalPV: true,
      deviceLocalPV: true,
    },
    // Configuration to set which openebs component is installed. Based on this, dashboards and alert rules configuration will be set.
    openenbsComponents: {
      ndm: true,
    },
    // dashboards configuration. If set, then dashboards json will be generated.
    dashboards: {
      cStor: $._config.casTypes.cStor,
      jiva: $._config.casTypes.jiva,
      localPV: $._config.casTypes.lvmLocalPV || $._config.casTypes.deviceLocalPV,
      lvmLocalPV: $._config.casTypes.lvmLocalPV,
      npd: true,
      ndm: $._config.openenbsComponents.ndm,
    },
    // AlertRules configuration. If set, then rules json will be generated.
    alertRules: {
      cStor: $._config.casTypes.cStor,
      jiva: $._config.casTypes.jiva,
      lvmLocalPV: $._config.casTypes.lvmLocalPV,
      volume: $._config.casTypes.cStor || $._config.casTypes.jiva || $._config.casTypes.lvmLocalPV || $._config.casTypes.deviceLocalPV,
      npd: true,
    },
  },
}
