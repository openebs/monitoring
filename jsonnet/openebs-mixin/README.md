# openebs mixin

A set of Grafana dashboards and Prometheus alerts for openebs.

## Generate dashboards and rules

You can manually generate the alerts, dashboards and rules files. 

#### Steps:

1. Install `jsonnet` and `jb`
	```
	$ go get github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb
	$ brew install jsonnet
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

The  files in `rulesDirPath` are the alert rules defined for openebs which has to be used to create prometheusRule yaml then need to passed to your Prometheus server, and the files in `dashboardsDirPath` need to be imported into you Grafana server. 

## Configuration

The available fields and their default values can be seen in `config.libsonnet`. 

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