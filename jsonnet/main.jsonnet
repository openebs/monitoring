local podMonitors = import './addons/podMonitors.libsonnet';
local rules = import './addons/prometheusRules.libsonnet';
local serviceMonitor = import './addons/serviceMonitors.libsonnet';
local config = import './config.libsonnet';
local openebsMixin = config.openebsMixin;

local kp =
  config.kp {
    values+:: {
      grafana+: {
        dashboards+: openebsMixin.grafanaDashboards,
      },
      prometheus+: {
        namespaces: [],
      },
    },
  };

{ 'setup/0namespace-namespace': kp.kubePrometheus.namespace } +
{
  ['setup/prometheus-operator-' + name]: kp.prometheusOperator[name]
  for name in std.filter((function(name) name != 'serviceMonitor' && name != 'prometheusRule'), std.objectFields(kp.prometheusOperator))
} +
// serviceMonitor and prometheusRule are separated so that they can be created after the CRDs are ready
{ 'prometheus-operator-serviceMonitor': kp.prometheusOperator.serviceMonitor } +
{ 'prometheus-operator-prometheusRule': kp.prometheusOperator.prometheusRule } +
{ 'kube-prometheus-prometheusRule': kp.kubePrometheus.prometheusRule } +
{ ['alertmanager-' + name]: kp.alertmanager[name] for name in std.objectFields(kp.alertmanager) } +
{ ['grafana-' + name]: kp.grafana[name] for name in std.objectFields(kp.grafana) } +
{ ['kube-state-metrics-' + name]: kp.kubeStateMetrics[name] for name in std.objectFields(kp.kubeStateMetrics) } +
{ ['kubernetes-' + name]: kp.kubernetesControlPlane[name] for name in std.objectFields(kp.kubernetesControlPlane) }
{ ['node-exporter-' + name]: kp.nodeExporter[name] for name in std.objectFields(kp.nodeExporter) } +
{ ['prometheus-' + name]: kp.prometheus[name] for name in std.objectFields(kp.prometheus) } +


// servicemonitor, podmonitor and prometheusrules for different casTypes of openebs
{ ['openebs-addons/openebs-servicemonitor-' + casType]: serviceMonitor.serviceMonitors[casType] for casType in std.objectFields(serviceMonitor.serviceMonitors) } +
{ ['openebs-addons/openebs-podmonitor-' + casType]: podMonitors.podMonitors[casType] for casType in std.objectFields(podMonitors.podMonitors) } +
{ ['openebs-addons/openebs-rule-' + name]: rules.prometheusRules[name] for name in std.objectFields(rules.prometheusRules) }
