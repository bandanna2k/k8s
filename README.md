
# Examples


## Stackoverflow

Lets distinguish between three scenarios where connecting to the cluster is required

1. **Connecting to Kubernetes API Server**

Connecting to the API server is required for administrative purposes. The users of your application have no business with it. The following options are available
- Connect directly to Master IP via HTTPS
- Kubectl Proxy Use `kubectl proxy` to to make the Kubernetes API available on your localhost.

2. **Connecting external traffic to your applications running in the Kubernetes Cluster.**

Here you want to expose your applications to your users. You'll need to configure a Service and they can be of the following types
- NodePort: Only accessible on the NodeIPs and ports > 30000
- ClusterIP: Internal Only. External traffic cannot hit a service of type ClusterIP directly. Requires ingress resource & ingress controller to receive external traffic.
- LoadBalancer: Allows you receive external traffic to one and only one service

Ingress: This isn't a type of service, it is another type of Kubernetes resource. By configuring NGINX Ingress for example, you can handle traffic to multiple ClusterIP services with only on external LoadBalancer.

3. **A Developer needs to troubleshoot a pod/service:** 
`kubectl port-forward`: Port forwarding example Requires kubectl to be configured on the system hence it cannot be used 
for all users of the application

As you can see from the above explanation, the proxy and port-forwarding option aren't viable options for connecting 
external traffic to the applications running because it requires your kubectl installed and configured with a valid 
kubeconfig which grants access into your cluster.





## Done

- DONE  Use nginx for images, hello world style
- DONE YAML file into k8s (DONE, kubectl apply -f) 
- DONE Load images (DONE)
- DONE Access from the outside

## Todo
- Secrets
- Ingress
- Push to EKS in AWS
- 2 services in same the pod talking
- 2 services in different pod talking