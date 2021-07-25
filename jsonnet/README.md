# OpenEBS Monitoring
This repository collects Kubernetes manifests, Grafana dashboards, and Prometheus rules to monitor openebs with the help of kube-prometheus stack.

The content of this project is written in jsonnet. This project could both be described as a package as well as a library.


## Generate manifests

1. Clone the repo:

	```
	$ git clone https://github.com/openebs/monitoring
	$ cd monitoring/jsonnet
	```

2. Generate the manifests:

	```
	$ make generate
	```
	
	The  files in `manifests/` are the yamls that have to be applied on the kubernetes cluster.  

3. Apply the kube-prometheus stack and openebs monitoring addons:  
   The previous step has generated a bunch of manifest files in the `manifests/` directory. Now simply use kubectl to install Prometheus and Grafana as per your configuration:

	```
	# Apply kube-prometheus stack yamls
	$ kubectl apply -f manifests/setup
	$ kubectl apply -f manifests/

	# Apply the openebs monitoring addons
	$ kubectl apply -f manifests/openebs-addons

	```
