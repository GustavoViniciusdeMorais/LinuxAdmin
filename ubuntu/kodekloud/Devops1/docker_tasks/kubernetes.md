# Kubernetes
- [Configs files](./k8_ymls_configs.md)
- Create a pod config file
- Create the pod and check if is running
- k is same as kubectl
```bash
k run pod --image httpd:latest --dry-run=client -o yaml > pod.yml
nano pod.yml
k apply -f pod.yml
k get pods # kubectl get pods
```
