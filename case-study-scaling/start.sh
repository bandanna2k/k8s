
# TODO Work in progress

set -e

source stop.sh
source lint.sh

# Start and wait to be ready
minikube start
minikube addons enable metrics-server
minikube kubectl -- wait pod --all --for=condition=Ready --namespace=kube-system --timeout=60s

source apply.sh
minikube kubectl -- wait pod --all --for=condition=Ready --namespace=education --timeout=120s

source ../current-state.sh

echo "Start load generation Press enter to continue."
read
source ./generate-load.sh

set -x

