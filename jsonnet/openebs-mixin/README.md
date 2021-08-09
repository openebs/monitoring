# openebs mixin

A set of Grafana dashboards and Prometheus alerts for openebs.

## Generate dashboards and rules

You can manually generate the alerts, dashboards and rules files. 

#### Steps:

1. Install `jsonnet` and `jb`
	```
	$ go get github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb
	$ sudo apt-get install jsonnet
	```

2. Then, grab the mixin and its dependencies:

	```
	$ git clone https://github.com/openebs/monitoring
	$ cd monitoring/jsonnet/openebs-mixin
	$ jb install
	```

3. Update the dashboards and rules directory path in `build.sh`
	```
	dashboardsDirPath = ''
	rulesDirPath = ''
	```

4. Finally, build the mixin:

	```
	$ make generate
	```

The files in `rulesDirPath` contain Prometheus-based alert rules for OpenEBS. These files will be aggregated to form a prometheusRule yaml that need to be imported into your Prometheus instance.
Similarly, the files in `dashboardsDirPath` are dashboard json files that need to be imported into your Grafana instance.

## Configuration

The available fields and their default values are present in `config.libsonnet`. 

```
{
  // openebs-mixin configurations
  _config+:: {
    // Configuration to set which cas types is installed. Based on this, dashboards and alert rules configuration will be set.
    casTypes: {
      cStor: true,
      jiva: true,
      lvmLocalPV: true,
      deviceLocalPV: true,
    },
    // dashboards configuration. If set, then dashboards json will be generated.
    dashboards: {
      cStor: $._config.casTypes.cStor,
      jiva: $._config.casTypes.jiva,
      localPV: $._config.casTypes.lvmLocalPV || $._config.casTypes.deviceLocalPV,
      lvmLocalPV: $._config.casTypes.lvmLocalPV,
      npd: true,
    },
    // AlertRules configuration. If set, then rules json will be generated.
    alertRules: {
      cStor: $._config.casTypes.cStor,
      jiva: $._config.casTypes.jiva,
      lvmLocalPV: $._config.casTypes.lvmLocalPV,
      volume: $._config.casTypes.cStor || $._config.casTypes.jiva || $._config.casTypes.lvmLocalPV || $._config.casTypes.deviceLocalPV,
      npd: true,
    },
  },
}
```
---

## How to use openebs-mixin?
Please visit the [user guide](../../docs/openebs-mixin-user-guide.md) for detailed instructions.