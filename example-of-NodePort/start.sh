set -e

source lint.sh

# Start and wait to be ready
minikube start
minikube kubectl -- wait pod --all --for=condition=Ready --namespace=kube-system --timeout=60s

source apply.sh

# Monitor
watch minikube kubectl -- get pods -A

