function(param) {
  //local rules = self,
  _config+:: param,
  prometheusRules+:: {
    cStorVolume: {
      groups+: [
        {
          name: 'openebs-cStor-volume',
          rules: [
            {
              alert: 'VolumeCapacityLow',
              annotations: {
                componentType: 'volume',
                openebsVolume: '{{ $labels.openebs_pv }}',
                openebsVolumeClaim: '{{ $labels.openebs_pvc }}',
                description: "OpenEBS volume '{{$labels.openebs_pv}}' created for '{{$labels.openebs_pvc}}' is running low on capacity, you have already consumed {{ $value }}% of total capacity",
                summary: "OpenEBS volume '{{$labels.openebs_pv}}' created for '{{$labels.openebs_pvc}}' has {{ with printf \"openebs_size_of_volume{openebs_pv='%s',instance='%s',job='%s',kubernetes_pod_name='%s',openebs_pvc='%s'}-openebs_actual_used{openebs_pv='%s',instance='%s',job='%s',kubernetes_pod_name='%s',openebs_pvc='%s'}\" $labels.openebs_pv $labels.instance $labels.job $labels.kubernetes_pod_name $labels.openebs_pvc $labels.openebs_pv $labels.instance $labels.job $labels.kubernetes_pod_name $labels.openebs_pvc | query }} {{ . | first | value }} {{ end }}GB) space remaining.",
              },
              expr: '((openebs_actual_used{openebs_cstor_label="cstor-volume-manager"}/openebs_size_of_volume{openebs_cstor_label="cstor-volume-manager"})*100 > 90)',
              'for': '2m',
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
