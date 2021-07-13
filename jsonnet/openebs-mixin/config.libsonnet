{
  _config+:: {
    dashboards: {
      cStor: true,
      Jiva: true,
      LocalPV: true,
    },
    alertRules: {
      cStor: true,
      Jiva: true,
      LocalPV: false,
      volume: true,
    },
  },
}
