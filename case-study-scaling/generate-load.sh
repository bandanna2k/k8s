NAME=load-generator-$(date +%s)

kubectl create job $NAME \
 -n education \
 --image=busybox:1.28 \
 -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"

echo "Waiting to stop load generation. Press enter to continue."
read
kubectl delete job $NAME -n education
