set -e

source lint.sh

# Start and wait to be ready
minikube start
minikube kubectl -- wait pod --all --for=condition=Ready --namespace=kube-system --timeout=60s

source apply.sh
minikube kubectl -- wait pod --all --for=condition=Ready --namespace=education --timeout=60s

minikube kubectl -- port-forward -n education pod/nginx1 10080:80 &
minikube kubectl -- port-forward -n education pod/nginx2 10081:80 &
sleep 1

curl -I http://localhost:10080/
curl -I http://localhost:10081/
