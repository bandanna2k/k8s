echo "WORK IN PROGRESS (Need to expose to outside world"

set -e


source stop.sh
source lint.sh

minikube start

minikube addons list |grep ingress
minikube addons enable ingress
minikube addons list |grep ingress

kubectl get ingress -n education

# Start and wait to be ready
minikube kubectl -- wait pod --all --for=condition=Ready --namespace=kube-system --timeout=60s

source apply.sh
minikube kubectl -- wait pod --all --for=condition=Ready --namespace=education --timeout=60s

#
#IP=`minikube ip`
#kubectl patch service -n education nginx-loadbalancer -p '{"spec": {"type": "LoadBalancer", "externalIPs":["'${IP}'"]}}'
#
#set -x
#URL=`minikube service -n education nginx-loadbalancer --url`
#curl -I $URL
#



IP=`minikube ip` curl -I http://${IP}

