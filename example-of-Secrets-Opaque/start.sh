./stop.sh

set -e

source lint.sh

# Start and wait to be ready
minikube start

minikube kubectl -- wait pod --all --for=condition=Ready --namespace=kube-system --timeout=60s

source apply.sh
minikube kubectl -- wait pod --all --for=condition=Ready --namespace=education --timeout=60s

URL=`minikube service -n education db-node-port --url`

set -x

MYSQL=~/Code/buck-all/opt/percona57centos8/bin/mysql

IP=`minikube ip`
$MYSQL -h $IP -P 30006 -u root -pmy-password -e "show databases"

kubectl exec -n education -c mysql db-pod -- cat "/etc/secret/username"

echo
