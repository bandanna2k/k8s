set -e

source lint.sh

# Start and wait to be ready
minikube start
minikube kubectl -- wait pod --all --for=condition=Ready --namespace=kube-system --timeout=60s

source apply.sh
minikube kubectl -- wait pod --all --for=condition=Ready --namespace=education --timeout=60s

URL1=`minikube service -n education node-port1 --url`
URL2=`minikube service -n education node-port2 --url`

set -x
curl -I $URL1
curl -I $URL2

