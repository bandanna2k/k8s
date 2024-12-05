URL1=`minikube service -n education node-port1 --url`
URL2=`minikube service -n education node-port2 --url`

set -x
curl -I $URL1
curl -I $URL2


