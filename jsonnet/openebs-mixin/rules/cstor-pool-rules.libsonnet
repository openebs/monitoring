function(param) {
  local rules = self,
  _config+:: param,
  prometheusRules+:: {
    cStorPool: {
      groups+: [
        {
          name: 'openebs-cStor-pool',
          rules: [
            {
              alert: 'PoolCapacityLow',
              annotations: {
                componentType: 'pool',
                cstorPool: '{{ $labels.cstor_pool }}',
                storageClassClaim: '{{ $labels.storage_pool_claim }}',
                description: 'OpenEBS Pool {{ $labels.cstor_pool }} use more than 80% of his capacity',
                summary: "cStor pool '{{$labels.cstor_pool}}' created for pool claim '{{$labels.storage_pool_claim}}' has {{ with printf \"openebs_free_pool_capacity{cstor_pool='%s',instance='%s',job='%s',kubernetes_pod_name='%s',slave='%s',storage_pool_claim='%s'}/(1024*1024*1024)\" $labels.cstor_pool $labels.instance $labels.job $labels.kubernetes_pod_name $labels.slave $labels.storage_pool_claim | query }} {{ . | first | value }} {{ end }}GB space remaining out of {{ with printf \"openebs_pool_size{cstor_pool='%s',instance='%s',job='%s',kubernetes_pod_name='%s',slave='%s',storage_pool_claim='%s'}/(1024*1024*1024)\" $labels.cstor_pool $labels.instance $labels.job $labels.kubernetes_pod_name $labels.slave $labels.storage_pool_claim | query }} {{ . | first | value }} {{ end }} GB. You have already consumed {{ $value }} percent of total capacity",
              },
              expr: 'openebs_used_pool_capacity_percent > 80',
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
