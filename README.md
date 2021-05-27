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

#### Install Chart

Please visit the [link](https://openebs.github.io/monitoring/) for install instructions via helm3.

```console
# Helm
helm install [RELEASE_NAME] openebs-monitoring/openebs-monitoring --namespace [NAMESPACE] --create-namespace
```

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

#### Accessing Grafana

```console
# Look at the grafana pod and note the node name on which this pod is running
kubectl get pods -n [NAMESPACE] -o wide | grep grafana
# Note the public IP of the node on which grafana pod is running
kubectl get nodes -o wide
# Open browser and visit http://<NodeIp>:<NodePort> (where <NodeIp> is the public IP address of your node, and default Grafana <NodePort> is 32515)
# Default Grafana login credentials- [username: admin, password: admin]
```
**NOTE:** If public IP is not available then you can access it via port-forwarding

```console
# Perform port-forwarding
kubectl port-forward --namespace [NAMESPACE] pods/[grafana-pod-name] 32515:3000
# Open browser and visit http://127.0.0.1:32515
# Default Grafana login credentials- [username: admin, password: admin]
```

<!-- Keep full URL links to repo files because this README syncs from main to gh-pages.  -->
The detailed chart documentation is available in [openebs-monitoring directory](https://github.com/openebs/monitoring/blob/develop/deploy/charts/openebs-monitoring/README.md).

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
