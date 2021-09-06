# OpenEBS Monitoring add-on

[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fopenebs%2Fmonitoring.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fopenebs%2Fmonitoring?ref=badge_shield)

A set of Grafana dashboards and Prometheus alerts for OpenEBS that can be installed as an [helm chart](./deploy/charts/) or imported as [jsonnet mixin](./jsonnet/).

## Status

**Beta**. Under active development and seeking [contributions from the community](#contributing).
This repository currently supports dashboards and alerts for `cStor`, `Jiva`, `LVM LocalPV` OpenEBS storage engines.


## Install

### Using helm

Setup the monitoring helm repository.

```console
helm repo add openebs-monitoring https://openebs.github.io/monitoring/
helm repo update
```

You can then run `helm search repo openebs-monitoring` to see the charts.

Install the helm chart. 
```
helm install openebs-monitoring openebs-monitoring/openebs-monitoring --namespace openebs --create-namespace
```

The detailed chart documentation is available in [charts directory](/deploy/charts/README.md).

### Using kubectl

```
git clone https://github.com/openebs/monitoring.git
cd monitoring/deploy/yaml
kubectl create -f openebs-monitoring.generated.crds.yaml
kubectl create -f openebs-monitoring.generated.yaml
```

> Note: The above files are generated using `helm tempalate` as follows: 
> ```
> git clone https://github.com/openebs/monitoring.git
> cd monitoring/deploy/charts
> helm dependency update
> helm template openebs-monitoring . --include-crds --namespace openebs > openebs-monitoring.generated.yaml
> #Copy the CRDs into ../yaml/openebs-monitoring.generated.crds.yaml
> #Copy the rest into ../yaml/openebs-monitoring.generated.yaml
> ```

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

OpenEBS welcomes your feedback and contributions in any form possible.

- Want to raise an issue or help with fixes and features?
    - See [open issues](https://github.com/openebs/monitoring/issues)
    - See [Project Roadmap](https://github.com/orgs/openebs/projects/41)
- See [contributing guide](./CONTRIBUTING.md)

## Community

- [Join OpenEBS community on Kubernetes Slack](https://kubernetes.slack.com)
  - Already signed up? Head to our discussions at [#openebs](https://kubernetes.slack.com/messages/openebs/)
  - Want to join our contributor community meetings, [check this out](https://github.com/openebs/openebs/blob/HEAD/community/README.md).
- Join our OpenEBS CNCF Mailing lists
  - For OpenEBS project updates, subscribe to [OpenEBS Announcements](https://lists.cncf.io/g/cncf-openebs-announcements)
  - For interacting with other OpenEBS users, subscribe to [OpenEBS Users](https://lists.cncf.io/g/cncf-openebs-users)

## Code of conduct

Participation in the OpenEBS community is governed by the [CNCF Code of Conduct](https://github.com/cncf/foundation/blob/HEAD/code-of-conduct.md).


## License
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fopenebs%2Fmonitoring.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fopenebs%2Fmonitoring?ref=badge_large)
