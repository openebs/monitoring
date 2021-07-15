# node-problem-detector metrics

Here is a list of metrics exported by node-probl3em-detector metrics when kernel-monitor and docker-monitor is only enabled. Other rules can also be monitored by adding them to the `log_monitors` field in the values.yaml used by [node-problem-detector](https://git.app.uib.no/caleno/helm-charts/-/blob/master/stable/node-problem-detector/values.yaml). Accordingly the metrics will also appear.

## Metrics by enabling kernel-monitor

```
problem_counter{reason="OOMKilling"} # system logs with pattern- "Killed process \\d+ (.+) total-vm:\\d+kB, anon-rss:\\d+kB, file-rss:\\d+kB._"
problem_counter{reason="TaskHung"} # system logs with pattern- "task [\\S ]+:\\w+ blocked for more than \\w+ seconds\\."
problem_counter{reason="UnregisterNetDevice"} # system logs with pattern- "unregister_netdevice: waiting for \\w+ to become free. Usage count = \\d+"
problem_counter{reason="KernelOops"} # system logs with pattern- "BUG: unable to handle kernel NULL pointer dereference at ._"
problem_counter{reason="KernelOops"} # system logs with pattern- "divide error: 0000 \\[#\\d+\\] SMP"
problem_counter{reason="Ext4Error"} # system logs with pattern- "EXT4-fs error ._"
problem_counter{reason="Ext4Warning"} # system logs with pattern- "EXT4-fs warning ._"
problem_counter{reason="IOError"} # system logs with pattern- "Buffer I/O error ._"
problem_counter{reason="MemoryReadError"} # system logs with pattern- "CE memory read error ._"
problem_counter{reason="AUFSUmountHung"} # system logs with pattern- "task umount\\.aufs:\\w+ blocked for more than \\w+ seconds\\."
problem_counter{reason="DockerHung"} # system logs with pattern- "task docker:\\w+ blocked for more than \\w+ seconds\\."
problem_counter{reason="FilesystemIsReadOnly"} # system logs with pattern- "Remounting filesystem read-only"
```

## Metrics by enabling docker-monitor

```
problem_counter{reason="CorruptDockerImage"} # system logs with pattern- "Error trying v2 registry: failed to register layer: rename /var/lib/docker/image/(.+) /var/lib/docker/image/(.+): directory not empty._"
problem_counter{reason="CorruptDockerOverlay2"} # system logs with pattern- "returned error: readlink /var/lib/docker/overlay2._: invalid argument.\*"
problem_counter{reason="DockerContainerStartupFailure"} # system logs with pattern- "OCI runtime start failed: container process is already dead: unknown"
```
