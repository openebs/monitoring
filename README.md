# OpenEBS Monitoring add-on
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fopenebs%2Fmonitoring.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fopenebs%2Fmonitoring?ref=badge_shield)


A set of Grafana dashboards and Prometheus alerts for OpenEBS, packaged as helm chart.

You have the following options for deploying OpenEBS monitoring dashboards
- Install [OpenEBS Monitoring Add-on](#install) that includes Prometheus Operator and OpenEBS Mixins.
- Install Only [OpenEBS Mixins](./docs/guide.md).

## Status

Pre-alpha. Under active development.

## Install

### Install using Helm Chart

- Step 1: [Helm](https://helm.sh) must be installed to use the charts. Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

- Step 2: Add OpenEBS Monitoring chart to Helm using the following command:
  ```console
  helm repo add openebs-monitoring https://openebs.github.io/monitoring/
  ```

  You can then run `helm search repo openebs-monitoring` to see the charts.

- Step 3: Install OpenEBS Monitoring add-on. 
  Please visit the [link](./deploy/charts/openebs-monitoring/README.md) for install customizations.
  ```console
  # Helm
  helm install [RELEASE_NAME] openebs-monitoring/openebs-monitoring --namespace [NAMESPACE] --create-namespace
  ```

### Install using generated YAML

Generate YAMLs using [Helm](https://helm.sh) template.

```
git clone https://github.com/openebs/monitoring.git
cd monitoring/deploy/charts/openebs-monitoring
helm dependency update
helm template --namespace openebs . > openebs-monitoring.generated.yaml
kubectl create -f openebs-monitoring.generated.yaml
```

## Usage

### Accessing Grafana

```console
# Look at the grafana pod and check that the pod is in running state
kubectl get pods -n [NAMESPACE] | grep -i grafana
# Note the public IP of any one of the nodes
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


## License
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fopenebs%2Fmonitoring.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fopenebs%2Fmonitoring?ref=badge_large)
