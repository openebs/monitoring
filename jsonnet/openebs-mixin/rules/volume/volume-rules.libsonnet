// alert rules for volume-pvc
function(param) {
  //local rules = self,
  _config+:: param,
  prometheusRules+:: {
    volume: {
      groups+: [
        {
          name: 'persistent-volume-claim',
          rules: [
            {
              alert: 'StalePersistentVolumeClaim',
              annotations: {
                summary: "Persistent Volume Claim '{{ $labels.persistentvolumeclaim }}' in namespace '{{ $labels.namespace }}' is not consumed by any pod in any namespace",
                description: "Persistent Volume Claim '{{ $labels.persistentvolumeclaim }}' has no consumer",
              },
              expr: 'kube_persistentvolumeclaim_info unless (kube_persistentvolumeclaim_info * on(persistentvolumeclaim) group_left kube_pod_spec_volumes_persistentvolumeclaims_info) == 1',
              'for': '5m',
              labels: {
                severity: 'info',
              },
            },
            {
              alert: 'PendingPersistentVolumeClaim',
              annotations: {
                summary: "Persistent Volume Claim '{{ $labels.persistentvolumeclaim }}' pending in namespace '{{ $labels.namespace }}'",
                description: "Persistent Volume Claim '{{ $labels.persistentvolumeclaim }}' has been in pending state for more than 5 minutes",
              },
              expr: 'kube_persistentvolumeclaim_status_phase{phase="Pending"} == 1',
              'for': '5m',
              labels: {
                severity: 'warning',
              },
            },
            {
              alert: 'LostPersistentVolumeClaim',
              annotations: {
                summary: "Persistent Volume Claim '{{ $labels.persistentvolumeclaim }}' in namespace '{{ $labels.namespace }}' lost it's corresponding persistent volume",
                description: "Persistent Volume Claim '{{ $labels.persistentvolumeclaim }}' has been in lost state for more than 5 minutes",
              },
              expr: 'kube_persistentvolumeclaim_status_phase{phase="Lost"} == 1',
              'for': '5m',
              labels: {
                severity: 'warning',
              },
            },
          ],
        },
      ],
    },
  },
}
