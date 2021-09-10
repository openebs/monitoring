# Monitoring OpenEBS lvm-localpv volumes

## Metrics supported by lvm-localpv volumes as of the current release are:

### Logical volumes metrics:

```
lvm_lv_health_status # LV health status: [-1: undefined], [0: ""], [1: partial], [2: refresh needed], [3: mismatches exist]
lvm_lv_mda_total_size_bytes #  LVM LV metadata size in bytes
lvm_lv_mda_used_percent # LVM LV metadata used size in percentage(1-100)
lvm_lv_permission # LV permissions: [-1: undefined], [0: unknown], [1: writeable], [2: read-only], [3: read-only-override]
lvm_lv_raid_sync_action # For LV RAID, the current synchronization action being performed: [-1: undefined], [0: idle], [1: frozen], [2: resync], [3: recover], [4: check], [5: repair]
lvm_lv_snap_percent # LVM LV snap used size in percentage(1-100)
lvm_lv_total_size_bytes # LVM LV total size in bytes
lvm_lv_used_percent # LVM LV used size in percentage(1-100)
lvm_lv_when_full # For thin pools, behavior when full: [-1: undefined], [0: error], [1: queue]
```

### Physical volume metrics:

```
lvm_pv_device_size_bytes # LVM PV underlying device size in bytes
lvm_pv_free_size_bytes # LVM PV free size in bytes
lvm_pv_mda_free_size_bytes # LVM PV device free metadata area space in bytes
lvm_pv_mda_total_size_bytes # LVM PV device smallest metadata area size in bytes
lvm_pv_total_size_bytes # LVM PV total size in bytes
lvm_pv_used_size_bytes # LVM PV used size in bytes
```

### Volume group metrics:

```
lvm_vg_allocation_policy # VG allocation policy: [-1: undefined], [0: normal], [1: contiguous], [2: cling], [3: anywhere], [4: inherited]
lvm_vg_free_size_bytes # LVM VG free size in bytes
lvm_vg_lv_count # Number of LVs in VG
lvm_vg_max_lv_count # Maximum number of LVs allowed in VG or 0 if unlimited
lvm_vg_max_pv_count # Maximum number of PVs allowed in VG or 0 if unlimited
lvm_vg_mda_count # Number of metadata areas on this VG
lvm_vg_mda_free_size_bytes # Free metadata area space for this VG in bytes
lvm_vg_mda_total_size_bytes # Size of smallest metadata area for this VG in bytes
lvm_vg_mda_used_count # Number of metadata areas in use on this VG
lvm_vg_missing_pv_count # Number of PVs in VG which are missing
lvm_vg_permission # VG permissions: [-1: undefined], [0: writeable], [1: read-only]
lvm_vg_pv_count # Number of PVs in VG
lvm_vg_snap_count # Number of snapshots in VG
lvm_vg_total_size_bytes # LVM VG total size in bytes

```
