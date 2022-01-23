# Prerequisites
* Kind
* Kubectl
* Helm

# Setup
Add Nginx Helm repo:
```
helm repo add ingress-nginx 'https://kubernetes.github.io/ingress-nginx'
helm repo update
```

Install the cluster and its components:
```
. kind.sh
```

# Service
The echo server is accessible via `localhost/foo` and `localhost/bar`. It is possible to generate traffic using `./generate_traffic.sh`.  

It's possible to access the Prometheus server by using `kubectl port-forward <prometheus_pod_name> 9090` and accessing it via `localhost:9090`.