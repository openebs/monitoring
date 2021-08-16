# Monitoring node-disk-manager(NDM)

## Metrics exported by ndm cluster exporter as of the current release are

```
node_block_device_state # State of BlockDevice (0,1,2) = {Active, Inactive, Unknown}
node_error_request_count # No. of requests errored out by the exporter
node_reject_request_count # No. of requests rejected by the exporter
```

## Metrics exported by ndm node exporter as of the current release are

```
seachest_block_device_current_temperature_celsius # Current reported temperature of the blockdevice. -1 if not reported
seachest_block_device_current_temperature_valid # Validity of the current temperature data reported. 0 means not valid, 1 means valid
seachest_block_device_endurance_used_percent # Estimate of the percentage of the device life that has been used
seachest_block_device_highest_temperature_celsius # Highest reported temperature of the blockdevice. -1 if not reported
seachest_block_device_lowest_temperature_celsius # Lowest reported temperature of the blockdevice. -1 if not reported
seachest_block_device_total_read_bytes # total number of bytes read by a block device in bytes
seachest_block_device_total_written_bytes # total number of bytes written by a block device in bytes
seachest_block_device_utilization_rate_percent # Ratio of actual workload to manufacturer's designed workload for the device
seachest_error_request_count # No. of requests errored out by the exporter
seachest_reject_request_count # No. of requests rejected by the exporter
```
