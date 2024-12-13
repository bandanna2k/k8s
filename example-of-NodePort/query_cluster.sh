URL1=`minikube service -n education nginx-service1 --url`
URL2=`minikube service -n education nginx-service2 --url`

set -x
curl -I $URL1
curl -I $URL2


