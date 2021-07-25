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
    // Dashboards configuration. If set, then dashboards json will be generated.
    dashboards: {
      cStor: true,
      Jiva: true,
      LocalPV: true,
    },
    // AlertRules configuration. If set, then rules json will be generated.
    alertRules: {
      cStor: true,
      Jiva: true,
      lvmLocalPV: false,
      volume: true,
    },
  },
}
```