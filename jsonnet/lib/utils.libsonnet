local config = import '../config.libsonnet';
{
  // Template function to create object for kubernetes.
  _Object(apiVersion, kind, name):: {
    apiVersion: apiVersion,
    kind: kind,
    metadata: {
      name: name,
      labels: { name: name },
      annotations: {},
      namespace: config._config.openebsMonitoring.namespace,
    },
  },

  // Template function to create ServiceMonitor.
  ServiceMonitor(name, monitoringAddon): $._Object('monitoring.coreos.com/v1', 'ServiceMonitor', name) {
    local svm = self,
    sc:: {
      st: config._config.openebsMonitoringAddon,
    },
    spec: {
      endpoints: [
        svm.sc.st[monitoringAddon].serviceMonitor.endpoints,
      ],
      namespaceSelector: svm.sc.st[monitoringAddon].serviceMonitor.namespaceSelector,
      selector: svm.sc.st[monitoringAddon].serviceMonitor.selector,
    },
  },

  // Template function to create PodMonitor.
  PodMonitor(name, monitoringAddon): $._Object('monitoring.coreos.com/v1', 'PodMonitor', name) {
    spec: {
      podMetricsEndpoints: [
        config._config.openebsMonitoringAddon[monitoringAddon].podMonitor.podMetricsEndpoints,
      ],
      namespaceSelector: config._config.openebsMonitoringAddon[monitoringAddon].podMonitor.namespaceSelector,
      selector: config._config.openebsMonitoringAddon[monitoringAddon].podMonitor.selector,
    },
  },

  // Template function to create ConfigMap.
  ConfigMap(name): $._Object('v1', 'ConfigMap', name) {
    metadata+: {
      labels+: {
        grafana_dashboard: '1',
      },
    },
    data: {},
  },

  // Template function to create PrometheusRule.
  PrometheusRule(name): $._Object('monitoring.coreos.com/v1', 'PrometheusRule', name) {
    metadata+: {
      labels+: config.kp.values.common.ruleLabels,
    },
    spec: {
    },
  },
}
