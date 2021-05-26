# Monitoring cStor Engine

## Metrics supported by cStor volume as of the current release are

```
openebs_actual_used # Actual volume size used
openebs_connection_error_total # Total no of connection errors
openebs_connection_retry_total # Total no of connection retry requests
openebs_degraded_replica_count # Total no of degraded/ro replicas
openebs_healthy_replica_count # Total no of healthy replicas
openebs_logical_size # Logical size of volume
openebs_parse_error_total # Total no of parsing errors
openebs_read_block_count # Read Block count of volume
openebs_read_time # Read time on volume
openebs_reads # Read Input/Outputs on Volume
openebs_sector_size # sector size of volume
openebs_size_of_volume # Size of the volume requested
openebs_total_read_bytes # Total read bytes
openebs_total_replica_count # Total no of replicas connected to cas
openebs_total_write_bytes # Total write bytes
openebs_volume_status # Status of volume: (1, 2, 3, 4) = {Offline, Degraded, Healthy, Unknown}
openebs_volume_uptime # Time since volume has registered
openebs_write_block_count # Write Block count of volume
openebs_write_time # Write time on volume
openebs_writes # Write Input/Outputs on Volume
```

These metrics are collected by cStor ServiceMonitor that describes the cStor service targets to be monitored by Prometheus which
ultimately exposes the cStor volume endpoints where the above mentioned metrics are exposed.

## Metrics supported by cStor to export the cStorStoragePool usage statistics as Prometheus metrics

```
openebs_volume_replica_available_size # Available size of volume replica on a pool
openebs_volume_replica_used_size # Used size of volume replica on a pool
openebs_dispatched_io_count # Dispatched IO's count
openebs_free_pool_capacity # Free capacity in pool
openebs_inflight_io_count # Inflight IO's count
openebs_maya_exporter_version # A metric with a constant '1' value labeled by commit and version from which maya-exporter was built.
openebs_pool_size # Size of pool
openebs_pool_status # Status of pool (0, 1, 2, 3, 4, 5, 6)= {"Offline", "Online", "Degraded", "Faulted", "Removed", "Unavail", "NoPoolsAvailable"}
openebs_read_latency # Read latency on replica
openebs_rebuild_bytes # Rebuild bytes
openebs_rebuild_count # Rebuild count
openebs_rebuild_status # Status of rebuild on replica (0, 1, 2, 3, 4, 5, 6)= {"INIT", "DONE", "SNAP REBUILD INPROGRESS", "ACTIVE DATASET REBUILD INPROGRESS", "ERRORED", "FAILED", "UNKNOWN"}
openebs_replica_status # Status of replica (0, 1, 2, 3) = {"Offline", "Healthy", "Degraded", "Rebuilding"}
openebs_total_rebuild_done # Total number of rebuild done on replica
openebs_sync_count # Total number of sync on replica
openebs_sync_latency # Sync latency on replica
openebs_total_failed_rebuild # Total number of failed rebuilds on replica
openebs_total_read_bytes # Total read in bytes
openebs_total_read_count # Total read io count
openebs_total_rebuild_done # Total number of rebuild done on replica
openebs_total_write_bytes # Total write in bytes
openebs_total_write_count # Total write io count
openebs_used_pool_capacity # Capacity used by pool
openebs_used_pool_capacity_percent # Capacity used by pool in percent
openebs_used_size Used # size of pool and volume
openebs_volume_status # Status of volume (0, 1, 2, 3) = {"Offline", "Healthy", "Degraded", "Rebuilding"}
openebs_write_latency # Write latency on replica
openebs_zfs_command_error # zfs command error counter
openebs_zfs_list_command_error # zfs list command error counter
openebs_zfs_parse_error # zfs parse error counter
openebs_zfs_list_failed_to_initialize_libuzfs_client_error_counter # Total no of failed to initialize libuzfs client error in zfs list command
openebs_zfs_list_no_dataset_available_error_counter #  Total number of no datasets error in zfs list command
openebs_zfs_list_parse_error # Total number of zfs list parse errors
openebs_zfs_list_request_reject_count # Total number of rejected requests of zfs list
openebs_zfs_stats_command_error # Total number of zfs command errors
openebs_zfs_stats_parse_error_counter # Total number of zfs stats parse errors
openebs_zfs_stats_reject_request_count # Total number of rejected requests of zfs stats
openebs_zpool_list_command_error # Total number of zpool command error counter
openebs_zpool_list_failed_to_initialize_libuzfs_client_error_counter # Total number of initialize libuzfs client error
openebs_zpool_list_incomplete_stdout_error # Total number of incomplete stdout errors
openebs_zpool_list_no_pool_available_error  # Total number of no pool available errors
openebs_zpool_list_parse_error_count # Total number of parsing errors
openebs_zpool_list_reject_request_count # Total number of rejected requests of zpool command
```

These metrics are collected are cStor podMonitor which declaratively specifies how groups of cStor pool pods should be monitored.

# Monitoring Jiva Engine

## Metrics supported by Jiva volume as of the current release are

```
openebs_actual_used # Actual volume size used
openebs_connection_error_total # Total no of connection errors
openebs_connection_retry_total # Total no of connection retry requests
openebs_degraded_replica_count # Total no of degraded/ro replicas
openebs_healthy_replica_count # Total no of healthy replicas
openebs_logical_size # Logical size of volume
openebs_parse_error_total # Total no of parsing errors
openebs_read_block_count # Read Block count of volume
openebs_read_time # Read time on volume
openebs_reads # Read Input/Outputs on Volume
openebs_sector_size # sector size of volume
openebs_size_of_volume # Size of the volume requested
openebs_total_replica_count # Total no of replicas connected to cas
openebs_volume_status # Status of volume: (1, 2, 3, 4) = {Offline, Degraded, Healthy, Unknown}
openebs_volume_uptime # Time since volume has registered
openebs_write_block_count # Write Block count of volume
openebs_write_time # Write time on volume
openebs_writes # Write Input/Outputs on Volume
```

These metrics are collected by jiva ServiceMonitor that describes the jiva service targets to be monitored by Prometheus which
ultimately exposes the jiva volume endpoints where the above mentioned metrics are exposed.

# CSI metrics exposed

Here is the list of csi volume metrics exposed by k8s:-

```
kubelet_volume_stats_available_bytes
kubelet_volume_stats_capacity_bytes
kubelet_volume_stats_inodes
kubelet_volume_stats_inodes_free
kubelet_volume_stats_inodes_used
kubelet_volume_stats_used_bytes
```
