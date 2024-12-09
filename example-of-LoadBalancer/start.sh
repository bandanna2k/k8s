echo "WORK IN PROGRESS (Need to expose to outside world"

set -e

source stop.sh
source lint.sh

# Start and wait to be ready
minikube start
minikube kubectl -- wait pod --all --for=condition=Ready --namespace=kube-system --timeout=60s

source apply.sh
minikube kubectl -- wait pod --all --for=condition=Ready --namespace=education --timeout=60s

