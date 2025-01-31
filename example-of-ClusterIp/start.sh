set -e

source stop.sh
source lint.sh

# Start and wait to be ready
minikube start
minikube kubectl -- wait pod --all --for=condition=Ready --namespace=kube-system --timeout=60s

source apply.sh
minikube kubectl -- wait pod --all --for=condition=Ready --namespace=education --timeout=60s

set -x
minikube kubectl -- proxy --port=8080 &
sleep 1

# curl http://localhost:8080/api/v1/namespaces/education/services/cluster-ip1/proxy
curl http://localhost:8080/api/v1/namespaces/education/pods/
curl http://localhost:8080/api/v1/namespaces/education/services/


curl -I http://localhost:8080/api/v1/namespaces/education/services/cluster-ip1:8080/proxy
