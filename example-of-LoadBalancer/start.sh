set -e

source stop.sh
source lint.sh

# Start and wait to be ready
minikube start
minikube kubectl -- wait pod --all --for=condition=Ready --namespace=kube-system --timeout=60s

source apply.sh
minikube kubectl -- wait pod --all --for=condition=Ready --namespace=education --timeout=60s


IP=`minikube ip`
kubectl patch service -n education my-loadbalancer -p '{"spec": {"type": "LoadBalancer", "externalIPs":["'${IP}'"]}}'

URL=`minikube service -n education my-loadbalancer --url`
curl -I -X GET $URL

echo "Find exposed port"
kubectl describe -n education services/my-loadbalancer
export NODE_PORT="$(kubectl get -n education services/my-loadbalancer -o go-template='{{(index .spec.ports 0).nodePort}}')"
echo NODE_PORT=$NODE_PORT
curl -I -X GET http://"$IP:$NODE_PORT"

echo "Show load balancing"
curl http://"$IP:$NODE_PORT"
curl http://"$IP:$NODE_PORT"
curl http://"$IP:$NODE_PORT"
curl http://"$IP:$NODE_PORT"
curl http://"$IP:$NODE_PORT"
