# Node exporter metrics

Below is a list of metrics exported by the node-exporter coming from collectors that are enabled by default for Linux OS. This [link](https://github.com/prometheus/node_exporter#collectors) explains how we can enable specific collector(s) to get the metrics exported by those specific collectors.

```
node_arp_entries # ARP entries by device

node_boot_time_seconds # Node boot time, in unixtime

node_collector_evictions_number

node_collector_unhealthy_nodes_in_zone

node_collector_zone_health

node_collector_zone_size

node_context_switches_total # Total number of context switches

node_cooling_device_cur_state # Current throttle state of the cooling device

node_cooling_device_max_state # Maximum throttle state of the cooling device

node_cpu_guest_seconds_total # Seconds the CPUs spent in guests (VMs) for each mode

node_cpu_seconds_total # Seconds the CPUs spent in each mode

node_disk_discard_time_seconds_total # This is the total number of seconds spent by all discards

node_disk_discarded_sectors_total # The total number of sectors discarded successfully

node_disk_discards_completed_total # The total number of discards completed successfully

node_disk_discards_merged_total # The total number of discards merged

node_disk_io_now # The number of I/Os currently in progress

node_disk_io_time_seconds_total # Total seconds spent doing I/Os

node_disk_io_time_weighted_seconds_total # The weighted # of seconds spent doing I/Os

node_disk_read_bytes_total # The total number of bytes read successfully

node_disk_read_time_seconds_total # The total number of seconds spent by all reads

node_disk_reads_completed_total # The total number of reads completed successfully

node_disk_reads_merged_total # The total number of reads merged

node_disk_write_time_seconds_total # This is the total number of seconds spent by all writes

node_disk_writes_completed_total # The total number of writes completed successfully

node_disk_writes_merged_total # The number of writes merged

node_disk_written_bytes_total # The total number of bytes written successfully

node_entropy_available_bits # Bits of available entropy

node_entropy_pool_size_bits # Bits of entropy pool

node_exporter_build_info # A metric with a constant '1' value labeled by version, revision, branch, and goversion from which node_exporter was built

node_filefd_allocated # File descriptor statistics: allocated

node_filefd_maximum # File descriptor statistics: maximum

node_filesystem_avail_bytes # Filesystem space available to non-root users in bytes

node_filesystem_device_error # Whether an error occurred while getting statistics for the given device

node_filesystem_files # Filesystem total file nodes

node_filesystem_files_free # Filesystem total free file nodes

node_filesystem_free_bytes # Filesystem free space in bytes

node_filesystem_readonly # Filesystem read-only status

node_filesystem_size_bytes # Filesystem size in bytes

node_forks_total # Total number of forks

node_hwmon_chip_names # Annotation metric for human-readable chip names

node_hwmon_sensor_label # Label for given chip and sensor

node_hwmon_temp_celsius # Hardware monitor for temperature (input)

node_hwmon_temp_crit_alarm_celsius # Hardware monitor for temperature (crit_alarm)

node_hwmon_temp_crit_celsius # Hardware monitor for temperature (crit)

node_hwmon_temp_max_celsius # Hardware monitor for temperature (max)

node_intr_total # Total number of interrupts serviced

node_ipvs_connections_total # The total number of connections made

node_ipvs_incoming_bytes_total # The total amount of incoming data

node_ipvs_incoming_packets_total # The total number of incoming packets

node_ipvs_outgoing_bytes_total # The total amount of outgoing data

node_ipvs_outgoing_packets_total # The total number of outgoing packets

node_lifecycle_controller_rate_limiter_use

node_load1 # 1m load average

node_load15 # 15m load average

node_load5 # 5m load average

node_memory_Active_anon_bytes # Memory information field Active_anon_bytes

node_memory_Active_bytes # Memory information field Active_bytes

node_memory_Active_file_bytes # Memory information field Active_file_bytes

node_memory_AnonHugePages_bytes # Memory information field AnonHugePages_bytes

node_memory_AnonPages_bytes # Memory information field AnonPages_bytes

node_memory_Bounce_bytes # Memory information field Bounce_bytes

node_memory_Buffers_bytes # Memory information field Buffers_bytes

node_memory_Cached_bytes # Memory information field Cached_bytes

node_memory_CmaFree_bytes # Memory information field CmaFree_bytes

node_memory_CmaTotal_bytes # Memory information field CmaTotal_bytes

node_memory_CommitLimit_bytes # Memory information field CommitLimit_bytes

node_memory_Committed_AS_bytes # Memory information field Committed_AS_bytes

node_memory_DirectMap1G_bytes # Memory information field DirectMap1G_bytes

node_memory_DirectMap2M_bytes # Memory information field DirectMap2M_bytes

node_memory_DirectMap4k_bytes # Memory information field DirectMap4k_bytes

node_memory_Dirty_bytes # Memory information field Dirty_bytes

node_memory_FileHugePages_bytes # Memory information field FileHugePages_bytes

node_memory_FilePmdMapped_bytes # Memory information field FilePmdMapped_bytes

node_memory_HardwareCorrupted_bytes # Memory information field HardwareCorrupted_bytes

node_memory_HugePages_Free # Memory information field HugePages_Free

node_memory_HugePages_Rsvd # Memory information field HugePages_Rsvd

node_memory_HugePages_Surp # Memory information field HugePages_Surp

node_memory_HugePages_Total # Memory information field HugePages_Total

node_memory_Hugepagesize_bytes # Memory information field Hugepagesize_bytes

node_memory_Hugetlb_bytes # Memory information field Hugetlb_bytes

node_memory_Inactive_anon_bytes # Memory information field Inactive_anon_bytes

node_memory_Inactive_bytes # Memory information field Inactive_bytes

node_memory_Inactive_file_bytes # Memory information field Inactive_file_bytes

node_memory_KReclaimable_bytes # Memory information field KReclaimable_bytes

node_memory_KernelStack_bytes # Memory information field KernelStack_bytes

node_memory_Mapped_bytes # Memory information field Mapped_bytes

node_memory_MemAvailable_bytes # Memory information field MemAvailable_bytes

node_memory_MemFree_bytes # Memory information field MemFree_bytes

node_memory_MemTotal_bytes # Memory information field MemTotal_bytes

node_memory_Mlocked_bytes # Memory information field Mlocked_bytes

node_memory_NFS_Unstable_bytes # Memory information field NFS_Unstable_bytes

node_memory_PageTables_bytes # Memory information field PageTables_bytes

node_memory_Percpu_bytes # Memory information field Percpu_bytes

node_memory_SReclaimable_bytes # Memory information field SReclaimable_bytes

node_memory_SUnreclaim_bytes # Memory information field SUnreclaim_bytes

node_memory_ShmemHugePages_bytes # Memory information field ShmemHugePages_bytes

node_memory_ShmemPmdMapped_bytes # Memory information field ShmemPmdMapped_bytes

node_memory_Shmem_bytes # Memory information field Shmem_bytes

node_memory_Slab_bytes # Memory information field Slab_bytes

node_memory_SwapCached_bytes # Memory information field SwapCached_bytes

node_memory_SwapFree_bytes # Memory information field SwapFree_bytes

node_memory_SwapTotal_bytes # Memory information field SwapTotal_bytes

node_memory_Unevictable_bytes # Memory information field Unevictable_bytes

node_memory_VmallocChunk_bytes # Memory information field VmallocChunk_bytes

node_memory_VmallocTotal_bytes # Memory information field VmallocTotal_bytes

node_memory_VmallocUsed_bytes # Memory information field VmallocUsed_bytes

node_memory_WritebackTmp_bytes # Memory information field WritebackTmp_bytes

node_memory_Writeback_bytes # Memory information field Writeback_bytes

node_namespace_pod:kube_pod_info:

node_namespace_pod_container:container_cpu_usage_seconds_total:sum_rate

node_namespace_pod_container:container_memory_cache

node_namespace_pod_container:container_memory_rss

node_namespace_pod_container:container_memory_swap

node_namespace_pod_container:container_memory_working_set_bytes

node_netstat_Icmp6_InErrors # Statistic Icmp6InErrors

node_netstat_Icmp6_InMsgs # Statistic Icmp6InMsgs

node_netstat_Icmp6_OutMsgs # Statistic Icmp6OutMsgs

node_netstat_Icmp_InErrors # Statistic IcmpInErrors

node_netstat_Icmp_InMsgs # Statistic IcmpInMsgs

node_netstat_Icmp_OutMsgs # Statistic IcmpOutMsgs

node_netstat_Ip6_InOctets # Statistic Ip6InOctets

node_netstat_Ip6_OutOctets # Statistic Ip6OutOctets

node_netstat_IpExt_InOctets # Statistic IpExtInOctets

node_netstat_IpExt_OutOctets # Statistic IpExtOutOctets

node_netstat_Ip_Forwarding # Statistic IpForwarding

node_netstat_TcpExt_ListenDrops # Statistic TcpExtListenDrops

node_netstat_TcpExt_ListenOverflows # Statistic TcpExtListenOverflows

node_netstat_TcpExt_SyncookiesFailed # Statistic TcpExtSyncookiesFailed

node_netstat_TcpExt_SyncookiesRecv # Statistic TcpExtSyncookiesRecv

node_netstat_TcpExt_SyncookiesSent # Statistic TcpExtSyncookiesSent

node_netstat_TcpExt_TCPSynRetrans # Statistic TcpExtTCPSynRetrans

node_netstat_Tcp_ActiveOpens # Statistic TcpActiveOpens

node_netstat_Tcp_CurrEstab # Statistic TcpCurrEstab

node_netstat_Tcp_InErrs # Statistic TcpInErrs

node_netstat_Tcp_InSegs # Statistic TcpInSegs

node_netstat_Tcp_OutRsts # Statistic TcpOutRsts

node_netstat_Tcp_OutSegs # Statistic TcpOutSegs

node_netstat_Tcp_PassiveOpens # Statistic TcpPassiveOpens

node_netstat_Tcp_RetransSegs # Statistic TcpRetransSegs

node_netstat_Udp6_InDatagrams # Statistic Udp6InDatagrams

node_netstat_Udp6_InErrors # Statistic Udp6InErrors

node_netstat_Udp6_NoPorts # Statistic Udp6NoPorts

node_netstat_Udp6_OutDatagrams # Statistic Udp6OutDatagrams

node_netstat_Udp6_RcvbufErrors # Statistic Udp6RcvbufErrors

node_netstat_Udp6_SndbufErrors # Statistic Udp6SndbufErrors

node_netstat_UdpLite6_InErrors # Statistic UdpLite6InErrors

node_netstat_UdpLite_InErrors # Statistic UdpLiteInErrors

node_netstat_Udp_InDatagrams # Statistic UdpInDatagrams

node_netstat_Udp_InErrors # Statistic UdpInErrors

node_netstat_Udp_NoPorts # Statistic UdpNoPorts

node_netstat_Udp_OutDatagrams # Statistic UdpOutDatagrams

node_netstat_Udp_RcvbufErrors # Statistic UdpRcvbufErrors

node_netstat_Udp_SndbufErrors # Statistic UdpSndbufErrors

node_network_address_assign_type # address_assign_type value of /sys/class/net/<iface>

node_network_carrier # carrier value of /sys/class/net/<iface>

node_network_carrier_changes_total # carrier_changes_total value of /sys/class/net/<iface>

node_network_carrier_down_changes_total

node_network_carrier_up_changes_total

node_network_device_id # device_id value of /sys/class/net/<iface>

node_network_dormant # dormant value of /sys/class/net/<iface>

node_network_flags # flags value of /sys/class/net/<iface>

node_network_iface_id # iface_id value of /sys/class/net/<iface>

node_network_iface_link # iface_link value of /sys/class/net/<iface>

node_network_iface_link_mode # iface_link_mode value of /sys/class/net/<iface>

node_network_info # Non-numeric data from /sys/class/net/<iface>, value is always 1

node_network_mtu_bytes # mtu_bytes value of /sys/class/net/<iface>

node_network_name_assign_type # name_assign_type value of /sys/class/net/<iface>

node_network_net_dev_group # net_dev_group value of /sys/class/net/<iface>

node_network_protocol_type # protocol_type value of /sys/class/net/<iface>

node_network_receive_bytes_total # Network device statistic receive_bytes

node_network_receive_compressed_total # Network device statistic receive_compressed

node_network_receive_drop_total # Network device statistic receive_drop

node_network_receive_errs_total # Network device statistic receive_errs

node_network_receive_fifo_total # Network device statistic receive_fifo

node_network_receive_frame_total # Network device statistic receive_frame

node_network_receive_multicast_total # Network device statistic receive_multicast

node_network_receive_packets_total # Network device statistic receive_packets

node_network_speed_bytes # speed_bytes value of /sys/class/net/<iface>

node_network_transmit_bytes_total # Network device statistic transmit_bytes

node_network_transmit_carrier_total # Network device statistic transmit_carrier

node_network_transmit_colls_total # Network device statistic transmit_colls

node_network_transmit_compressed_total # Network device statistic transmit_compressed

node_network_transmit_drop_total # Network device statistic transmit_drop

node_network_transmit_errs_total # Network device statistic transmit_errs

node_network_transmit_fifo_total # Network device statistic transmit_fifo

node_network_transmit_packets_total # Network device statistic transmit_packets

node_network_transmit_queue_length # transmit_queue_length value of /sys/class/net/<iface>

node_network_up # Value is 1 if operstate is 'up', 0 otherwise

node_nf_conntrack_entries # Number of currently allocated flow entries for connection tracking

node_nf_conntrack_entries_limit # Maximum size of connection tracking table

node_nfsd_connections_total # Total number of NFSd TCP connections

node_nfsd_disk_bytes_read_total # Total NFSd bytes read

node_nfsd_disk_bytes_written_total # Total NFSd bytes written

node_nfsd_file_handles_stale_total # Total number of NFSd stale file handles

node_nfsd_packets_total # Total NFSd network packets (sent+received) by protocol type

node_nfsd_read_ahead_cache_not_found_total # Total number of NFSd read ahead cache not found

node_nfsd_read_ahead_cache_size_blocks # How large the read ahead cache is in blocks

node_nfsd_reply_cache_hits_total # Total number of NFSd Reply Cache hits (client lost server response)

node_nfsd_reply_cache_misses_total # Total number of NFSd Reply Cache an operation that requires caching (idempotent)

node_nfsd_reply_cache_nocache_total # Total number of NFSd Reply Cache non-idempotent operations (rename/delete/…)

node_nfsd_requests_total # Total number NFSd Requests by method and protocol

node_nfsd_rpc_errors_total # Total number of NFSd RPC errors by error type

node_nfsd_server_rpcs_total # Total number of NFSd RPCs

node_nfsd_server_threads # Total number of NFSd kernel threads that are running

node_power_supply_info # info of /sys/class/power_supply/<power_supply>

node_power_supply_online # online value of /sys/class/power_supply/<power_supply>

node_pressure_cpu_waiting_seconds_total # Total time in seconds that processes have waited for CPU time

node_pressure_io_stalled_seconds_total # Total time in seconds no process could make progress due to IO congestion

node_pressure_io_waiting_seconds_total # Total time in seconds that processes have waited due to IO congestion

node_pressure_memory_stalled_seconds_total # Total time in seconds no process could make progress due to memory congestion

node_pressure_memory_waiting_seconds_total # Total time in seconds that processes have waited for memory

node_procs_blocked # Number of processes blocked waiting for I/O to complete

node_procs_running # Number of processes in runnable state

node_schedstat_running_seconds_total # Number of seconds CPU spent running a process

node_schedstat_timeslices_total # Number of timeslices executed by CPU

node_schedstat_waiting_seconds_total # Number of seconds spent by processing waiting for this CPU

node_scrape_collector_duration_seconds # node_exporter: Duration of a collector scrape

node_scrape_collector_success # node_exporter: Whether a collector succeeded

node_sockstat_FRAG6_inuse # Number of FRAG6 sockets in state inuse

node_sockstat_FRAG6_memory # Number of FRAG6 sockets in state memory

node_sockstat_FRAG_inuse # Number of FRAG sockets in state inuse

node_sockstat_FRAG_memory # Number of FRAG sockets in state memory

node_sockstat_RAW6_inuse # Number of RAW6 sockets in state inuse

node_sockstat_RAW_inuse # Number of RAW sockets in state inuse

node_sockstat_TCP6_inuse # Number of TCP6 sockets in state inuse

node_sockstat_TCP_alloc # Number of TCP sockets in state alloc

node_sockstat_TCP_inuse # Number of TCP sockets in state inuse

node_sockstat_TCP_mem # Number of TCP sockets in state mem

node_sockstat_TCP_mem_bytes # Number of TCP sockets in state mem_bytes

node_sockstat_TCP_orphan # Number of TCP sockets in state orphan

node_sockstat_TCP_tw # Number of TCP sockets in state tw

node_sockstat_UDP6_inuse # Number of UDP6 sockets in state inuse

node_sockstat_UDPLITE6_inuse # Number of UDPLITE6 sockets in state inuse

node_sockstat_UDPLITE_inuse # Number of UDPLITE sockets in state inuse

node_sockstat_UDP_inuse # Number of UDP sockets in state inuse

node_sockstat_UDP_mem # Number of UDP sockets in state mem

node_sockstat_UDP_mem_bytes # Number of UDP sockets in state mem_bytes

node_sockstat_sockets_used # Number of IPv4 sockets in use

node_softnet_dropped_total # Number of dropped packets

node_softnet_processed_total # Number of processed packets

node_softnet_times_squeezed_total # Number of times processing packets ran out of quota

node_textfile_scrape_error # 1 if there was an error opening or reading a file, 0 otherwise

node_time_seconds # System time in seconds since epoch (1970)

node_timex_estimated_error_seconds # Estimated error in seconds

node_timex_frequency_adjustment_ratio # Local clock frequency adjustment

node_timex_loop_time_constant # Phase-locked loop time constant

node_timex_maxerror_seconds # Maximum error in seconds

node_timex_offset_seconds # Time offset in between local system and reference clock

node_timex_pps_calibration_total # Pulse per second count of calibration intervals

node_timex_pps_error_total # Pulse per second count of calibration errors

node_timex_pps_frequency_hertz # Pulse per second frequency

node_timex_pps_jitter_seconds # Pulse per second jitter

node_timex_pps_jitter_total # Pulse per second count of jitter limit exceeded events

node_timex_pps_shift_seconds # Pulse per second interval duration

node_timex_pps_stability_exceeded_total # Pulse per second count of stability limit exceeded events

node_timex_pps_stability_hertz # Pulse per second stability, average of recent frequency changes

node_timex_status # Value of the status array bits

node_timex_sync_status # Is clock synchronized to a reliable server (1 = yes, 0 = no)

node_timex_tai_offset_seconds # International Atomic Time (TAI) offset

node_timex_tick_seconds # Seconds between clock ticks

node_udp_queues # Number of allocated memory in the kernel for UDP datagrams in bytes

node_uname_info # Labeled system information as provided by the uname system call

node_vmstat_oom_kill # /proc/vmstat information field oom_kill

node_vmstat_pgfault # /proc/vmstat information field pgfault

node_vmstat_pgmajfault # /proc/vmstat information field pgmajfault

node_vmstat_pgpgin # /proc/vmstat information field pgpgin

node_vmstat_pgpgout # /proc/vmstat information field pgpgout

node_vmstat_pswpin # /proc/vmstat information field pswpin

node_vmstat_pswpout # /proc/vmstat information field pswpout
```
