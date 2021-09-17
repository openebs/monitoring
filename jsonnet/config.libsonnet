{
  // import kube-prometheus and override configurations
  kp:
    (import 'kube-prometheus/main.libsonnet') +
    (import 'kube-prometheus/addons/all-namespaces.libsonnet') +
    // Uncomment the following imports to enable its patches
    // (import 'kube-prometheus/addons/anti-affinity.libsonnet') +
    // (import 'kube-prometheus/addons/managed-cluster.libsonnet') +
    (import 'kube-prometheus/addons/node-ports.libsonnet') +
    // (import 'kube-prometheus/addons/static-etcd.libsonnet') +
    // (import 'kube-prometheus/addons/custom-metrics.libsonnet') +
    // (import 'kube-prometheus/addons/external-metrics.libsonnet') +
    {
      values+:: {
        common+: {
          namespace: $._config.openebsMonitoring.namespace,
        },
      },
    },

  // import openebs-mixin and override configurations
  openebsMixin: (import './openebs-mixin/mixin.libsonnet') {
    _config+:: {
      dashboards+: {
        cStor: $._config.openebsMonitoringAddon.cStor.dashboards,
        jiva: $._config.openebsMonitoringAddon.jiva.dashboards,
        localPV: $._config.openebsMonitoringAddon.lvmLocalPV.dashboards,
        lvmLocalPV: $._config.openebsMonitoringAddon.lvmLocalPV.dashboards,
        deviceLocalPV: $._config.openebsMonitoringAddon.deviceLocalPV.dashboards,
        zfsLocalPV: $._config.openebsMonitoringAddon.zfsLocalPV.dashboards,
        ndm: $._config.openebsMonitoringAddon.ndm.dashboards,
      },
      alertRules+: {
        cStor: $._config.openebsMonitoringAddon.cStor.alertRules,
        jiva: $._config.openebsMonitoringAddon.jiva.alertRules,
        lvmLocalPV: $._config.openebsMonitoringAddon.lvmLocalPV.alertRules,
        deviceLocalPV: $._config.openebsMonitoringAddon.deviceLocalPV.alertRules,
        zfsLocalPV: $._config.openebsMonitoringAddon.zfsLocalPV.alertRules,
        ndm: $._config.openebsMonitoringAddon.ndm.alertRules,
      },
    },
  },

  // Template function for ServiceMonitor
  local serviceMonitor(port, path, selectorName) = {
    // Endpoints of the selected service to be monitored
    endpoints: {

      // Name of the endpoint's service port
      port: port,

      // HTTP path to scrape for metrics
      path: path,
    },
    // Label selector for services to which this ServiceMonitor applies
    selector: {
      matchLabels: selectorName,
    },
    // Namespaces from which services are selected
    namespaceSelector: {
      any: true,
    },
  },

  // Template function for PodMonitor
  local podMonitor(port, path, selectorName) = {
    // Endpoints of the selected pods to be monitored
    podMetricsEndpoints: {
      // Name of the endpoint's service port
      port: port,

      // HTTP path to scrape for metrics
      path: path,
    },
    // Label selector for services to which this ServiceMonitor applies
    selector: {
      matchLabels: selectorName,
    },
    // Namespaces from which services are selected
    namespaceSelector: {
      any: true,
    },
  },

  // Configuration for openebs monitoring
  _config+:: {
    openebsMonitoring: {
      namespace: 'openebs',
    },
    // Configuration for different cas types.
    openebsMonitoringAddon: {
      cStor: {
        // To generate manifests for cstor. If set, manifests will be generated for cStor.
        enabled: true,
        // To generate dashboards configMap yamls. If set, dashboards will be appended in grafana-dashboardDefinition yaml.
        dashboards: true,
        // To generate prometheusRule yamls. If set, prometheusRule will be generated.
        alertRules: true,
        // ServiceMonitor configuration
        serviceMonitor: serviceMonitor('exporter', '/metrics', { 'openebs.io/cas-type': 'cstor' }) {
          enabled: true,
          endpoints+: {
            // relabel configs to apply to samples before ingestion.
            relabelings: [
              {
                sourceLabels: ['__meta_kubernetes_pod_label_monitoring'],
                regex: 'volume_exporter_prometheus',
                action: 'keep',
              },
              {
                sourceLabels: ['__meta_kubernetes_pod_label_vsm'],
                targetLabel: 'openebs_pv',
                action: 'replace',
              },
              {
                sourceLabels: ['__meta_kubernetes_pod_label_openebs_io_persistent_volume'],
                targetLabel: 'openebs_pv',
                action: 'replace',
              },
              {
                sourceLabels: ['__meta_kubernetes_pod_label_openebs_io_persistent_volume_claim'],
                targetLabel: 'openebs_pvc',
                action: 'replace',
              },
              {
                sourceLabels: ['__meta_kubernetes_endpoints_label_openebs_io_cas_type'],
                targetLabel: 'openebs_cas_type',
                action: 'replace',
              },
            ],
          },
        },
        // PodMonitor configuration
        podMonitor: podMonitor('exporter', '/metrics', {
          app: 'cstor-pool',
        }) {
          enabled: true,
          podMetricsEndpoints+: {
            // relabel configs to apply to samples before ingestion.
            relabelings: [
              {
                sourceLabels: ['__meta_kubernetes_pod_label_monitoring'],
                regex: 'pool_exporter_prometheus',
                action: 'keep',
              },
              {
                sourceLabels: ['__meta_kubernetes_pod_label_vsm'],
                targetLabel: 'openebs_pv',
                action: 'replace',
              },
              {
                sourceLabels: [
                  '__meta_kubernetes_pod_label_openebs_io_storage_pool_claim',
                  '__meta_kubernetes_pod_label_openebs_io_cstor_pool_cluster',
                ],
                separator: ' ',
                targetLabel: 'storage_pool_claim',
                action: 'replace',
              },
              {
                sourceLabels: ['__meta_kubernetes_pod_label_openebs_io_cstor_pool', '__meta_kubernetes_pod_label_openebs_io_cstor_pool_instance'],
                separator: ' ',
                targetLabel: 'cstor_pool',
                action: 'replace',
              },
              {
                sourceLabels: ['__address__', '__meta_kubernetes_pod_annotation_prometheus_io_port'],
                action: 'replace',
                regex: '([^:]+)(?::\\d+)?;(\\d+)',
                replacement: '${1}:${2}',
                targetLabel: '__address__',
              },
            ],
          },
        },
      },
      jiva: {
        // To generate manifests for cstor. If set, manifests will be generated for Jiva.
        enabled: true,
        // To generate dashboards configMap yamls. If set, dashboards will be appended in grafana-dashboardDefinition yaml.
        dashboards: true,
        // To generate prometheusRule yamls. If set, prometheusRule will be generated.
        alertRules: true,
        // ServiceMonitor configuration
        serviceMonitor: serviceMonitor('metrics', '/metrics', {
          'openebs.io/cas-type': 'jiva',
        }) {
          enabled: true,
          endpoints+: {
            // relabel configs to apply to samples before ingestion.
            relabelings: [
              {
                sourceLabels: ['__meta_kubernetes_pod_label_vsm'],
                targetLabel: 'openebs_pv',
                action: 'replace',
              },
              {
                sourceLabels: ['__meta_kubernetes_pod_label_openebs_io_persistent_volume'],
                targetLabel: 'openebs_pv',
                action: 'replace',
              },
              {
                sourceLabels: ['__meta_kubernetes_pod_label_openebs_io_persistent_volume_claim'],
                targetLabel: 'openebs_pvc',
                action: 'replace',
              },
              {
                sourceLabels: ['__meta_kubernetes_endpoints_label_openebs_io_cas_type'],
                targetLabel: 'openebs_cas_type',
                action: 'replace',
              },
            ],
          },
        },
        // PodMonitor configuration
        podMonitor: {
          enabled: false,
        },
      },
      lvmLocalPV: {
        // To generate manifests for cstor. If set, manifests will be generated for lvm-localpv.
        enabled: true,
        // To generate dashboards configMap yamls. If set, dashboards will be appended in grafana-dashboardDefinition yaml.
        dashboards: true,
        // To generate prometheusRule yamls. If set, prometheusRule will be generated.
        alertRules: true,
        // ServiceMonitor configuration
        serviceMonitor: serviceMonitor('metrics', '/metrics', {
          name: 'openebs-lvm-node',
        }) {
          enabled: true,
        },
        // PodMonitor configuration
        podMonitor: {
          enabled: false,
        },
      },
      deviceLocalPV: {
        // To generate manifests for device-localpv. If set, manifests will be generated for device-localpv.
        enabled: true,
        // To generate dashboards configMap yamls. If set, dashboards will be appended in grafana-dashboardDefinition yaml.
        dashboards: true,
        // To generate prometheusRule yamls. If set, prometheusRule will be generated.
        alertRules: false,
        // ServiceMonitor configuration
        serviceMonitor: serviceMonitor('metrics', '/metrics', {
          name: 'openebs-device-node',
        }) {
          enabled: true,
        },
        // PodMonitor configuration
        podMonitor: {
          enabled: false,
        },
      },
      ndm: {
        // To generate manifests for ndm. If set, manifests will be generated for ndm.
        enabled: true,
        // To generate dashboards configMap yamls. If set, dashboards will be appended in grafana-dashboardDefinition yaml.
        dashboards: true,
        // To generate prometheusRule yamls. If set, prometheusRule will be generated.
        alertRules: false,
        // ServiceMonitor configuration
        serviceMonitor: serviceMonitor('metrics', '/metrics', {
          name: 'openebs-ndm-exporter',
        }) {
          enabled: true,
        },
        // PodMonitor configuration
        podMonitor: {
          enabled: false,
        },
      },
      zfsLocalPV: {
        // To generate manifests for zfs localpv. If set, manifests will be generated.
        enabled: true,
        // To generate dashboards configMap yamls. If set, dashboards will be appended in grafana-dashboardDefinition yaml.
        dashboards: true,
        // To generate prometheusRule yamls. If set, prometheusRule will be generated.
        alertRules: false,
        // ServiceMonitor configuration
        serviceMonitor: {
          enabled: false,
        },
        // PodMonitor configuration
        podMonitor: {
          enabled: false,
        },
      },
    },
  },
}
