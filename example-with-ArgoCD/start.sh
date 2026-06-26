set -xe

source lint.sh

# Start and wait to be ready
minikube start
minikube kubectl -- wait pod --all --for=condition=Ready --namespace=kube-system --timeout=60s

# Argo
kubectl create namespace argocd
kubectl -n argocd apply --server-side -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl -n argocd wait  --for=condition=available deployment/argocd-server  --timeout=120s

kubectl -n argocd patch secret argocd-initial-admin-secret -p '{"data":{"password":"JDJhJDEyJFI5aC9jaVB6MGdpLlVSTk5YM2toMk9QU1Q5L1BnQmtxcXV6aS5TczcrS0lVZ08ydDBqV01VbQ=="}}'
kubectl -n argocd rollout restart deployment/argocd-server
kubectl -n argocd rollout status deployment/argocd-server --timeout=60s

# My cluster
source apply.sh
minikube kubectl -- wait pod --all --for=condition=Ready --namespace=education --timeout=60s

minikube kubectl -- port-forward -n education pod/nginx1         10080:80 &
minikube kubectl -- port-forward -n education pod/nginx2         10081:80 &
minikube kubectl -- port-forward -n argocd    svc/argocd-server  18080:443 &
sleep 2

curl -I http://localhost:10080/
curl -I http://localhost:10081/
