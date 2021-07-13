function(param) {
  local rules = self,
  _config+:: param,
  prometheusRules+:: {
    volumeNode: {
      groups+: [
        {
          name: 'volume-node',
          rules: [
            {
              alert: 'VolumeNodeFileSystemIsReadOnly',
              annotations: {
                summary: "Volume mount failed for persistent volume claim '{{ $labels.persistentvolumeclaim }}' on node '{{ $labels.node }}' due to read-only file-system",
                description: "Persistent Volume's filesystem on node '{{ $labels.node }}' for persistent volume claim '{{ $labels.persistentvolumeclaim }}' has become read-only",
              },
              expr: 'kubelet_volume_stats_inodes * on(node) group_left(reason) problem_counter{reason="FilesystemIsReadOnly"} > 0',
              'for': '5m',
              labels: {
                severity: 'critical',
              },
            },
            {
              alert: 'VolumeNodeExt4Error',
              annotations: {
                summary: "Node '{{ $labels.node }}' has encountered errors on ext4 file-system on volume having claim '{{ $labels.persistentvolumeclaim }}'",
                description: "Persistent Volume's on node '{{ $labels.node }}' persistent volume claim '{{ $labels.persistentvolumeclaim }}' encountering ext4 filesystem error",
              },
              expr: 'kubelet_volume_stats_inodes * on(node) group_left(reason) problem_counter{reason="Ext4Error"} > 0',
              'for': '5m',
              labels: {
                severity: 'critical',
              },
            },
            {
              alert: 'VolumeNodeIOError',
              annotations: {
                summary: "IO errors encountered on volume having persistent volume claim '{{ $labels.persistentvolumeclaim }}' on node '{{ $labels.node }}'",
                description: "Persistent Volume on node '{{ $labels.node }}' for persistent volume claim '{{ $labels.persistentvolumeclaim }}' encountering errors w.r.t buffer I/O ",
              },
              expr: 'kubelet_volume_stats_inodes * on(node) group_left(reason) problem_counter{reason="IOError"} > 0',
              'for': '5m',
              labels: {
                severity: 'critical',
              },
            },
            {
              alert: 'VolumeNodeExt4Warning',
              annotations: {
                summary: "Node '{{ $labels.node }}' has encountered warning on ext4 file-system on volume having claim '{{ $labels.persistentvolumeclaim }}'",
                description: "Persistent Volume on node '{{ $labels.node }}' receiving ext4 filesystem warning for persistent volume claim '{{ $labels.persistentvolumeclaim }}'",
              },
              expr: 'kubelet_volume_stats_inodes * on(node) group_left(reason) problem_counter{reason="Ext4Warning"} > 0',
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
