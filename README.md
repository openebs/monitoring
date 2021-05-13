# OpenEBS Monitoring add-on

This repository contains monitoring-related (like Prometheus, grafana, etc,) artifacts like helm charts/ YAMLs. The goal of this repository is to provide an easy to setup monitoring stack for OpenEBS. 

This repository will aggregate all the monitoring related artifacts that are currently spread across multiple repositories like:
* https://github.com/openebs/openebs/tree/master/k8s
* https://github.com/openebs/charts/tree/gh-pages/grafana-charts

## Status

Pre-alpha. Under active development.

## Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```console
helm repo add openebs-monitoring https://openebs.github.io/monitoring/
```

You can then run `helm search repo openebs-monitoring` to see the charts.

<!-- Keep full URL links to repo files because this README syncs from main to gh-pages.  -->
Chart documentation is available in [openebs-monitoring directory](https://github.com/openebs/monitoring/blob/develop/deploy/charts/openebs-monitoring/README.md).

## Contributing

OpenEBS community welcomes your feedback and contributions in any form possible.

Want to raise an issue or help with fixes and features?
- See [open issues](https://github.com/openebs/openebs/issues)
- See [contributing guide](./CONTRIBUTING.md)

## Community

- [Join OpenEBS community on Kubernetes Slack](https://kubernetes.slack.com)
  - Already signed up? Head to our discussions at [#openebs](https://kubernetes.slack.com/messages/openebs/)
  - Want to join our contributor community meetings, [check this out](https://github.com/openebs/openebs/blob/master/community/README.md).
- Join our OpenEBS CNCF Mailing lists
  - For OpenEBS project updates, subscribe to [OpenEBS Announcements](https://lists.cncf.io/g/cncf-openebs-announcements)
  - For interacting with other OpenEBS users, subscribe to [OpenEBS Users](https://lists.cncf.io/g/cncf-openebs-users)

## Code of conduct

Participation in the OpenEBS community is governed by the [CNCF Code of Conduct](https://github.com/cncf/foundation/blob/master/code-of-conduct.md).
