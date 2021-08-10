function(param) {
  //local rules = self,
  _config+:: param,
  prometheusRules+:: {
    lvmLocalPV: {
      groups+: [
        {
          name: 'lvm-pool',
          rules: [
            {
              alert: 'LVMVolumeGroupMissingPhysicalVolume',
              annotations: {
                componentType: 'volume group',
                vgName: '{{ $labels.name }}',
                summary: "LVM volume group '{{ $labels.name }}' is missing the underlying physical volume.",
                description: "LVM volume group '{{ $labels.name }}' on node '{{ $labels.instance }}' is missing {{ $value }} underlying physical volume(s).",
              },
              expr: 'lvm_vg_missing_pv_count > 0',
              'for': '5m',
              labels: {
                severity: 'critical',
              },
            },
            {
              alert: 'LVMVolumeGroupCapacityLow',
              annotations: {
                componentType: 'volume group',
                vgName: '{{ $labels.name }}',
                summary: "LVM volume group '{{ $labels.name }}' is running low on capacity. Already {{ $value }}% of total capacity is consumed.",
                description: "LVM volume group '{{ $labels.name }}' on node '{{ $labels.instance }}' has {{ with printf \"lvm_vg_free_size_bytes{instance='%s',name='%s'}\" $labels.instance $labels.name | query }} {{ . | first | value }} {{ end }}bytes of space remaining",
              },
              expr: '((lvm_vg_total_size_bytes - lvm_vg_free_size_bytes)/lvm_vg_total_size_bytes)*100 > 90',
              'for': '5m',
              labels: {
                severity: 'critical',
              },
            },
            {
              alert: 'LVMThinPoolCapacityLow',
              annotations: {
                componentType: 'logical volume',
                lvName: '{{ $labels.name }}',
                summary: "LVM thin pool '{{ $labels.name }}' is running low on capacity. Already {{ $value }}% of total capacity is consumed.",
                description: "LVM thin pool '{{ $labels.name }}' on node '{{ $labels.instance }}' has {{ with printf \"lvm_lv_total_size_bytes{instance='%s',name='%s',segtype='%s'}-((lvm_lv_used_percent{instance='%s',name='%s',segtype='%s'}*lvm_lv_total_size_bytes{instance='%s',name='%s',segtype='%s'})/100)\" $labels.instance $labels.name $labels.segtype $labels.instance $labels.name $labels.segtype $labels.instance $labels.name $labels.segtype | query }} {{ . | first | value }} {{ end }}bytes of space remaining",
              },
              expr: 'lvm_lv_used_percent{segtype="thin-pool"} > 90',
              'for': '5m',
              labels: {
                severity: 'critical',
              },
            },
          ],
        },
      ],
    },
  },
}
