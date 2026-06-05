# Kubernetes

- [Configs files](./k8_ymls_configs.md)
- [Commands descriptions](./k8s_cli_docs.md)

### First Pod Deploy
k is same as kubectl
```bash
k run pod --image httpd:latest --dry-run=client -o yaml > pod.yml
nano pod.yml
k apply -f pod.yml
k get pods # kubectl get pods
```
### Expose service port
```bash
k create deploy nginx --image nginx:latest
k scale deploy nginx --replicas 3
k get rs
k expose deploy nginx --port 80 --target-port 80 --type NodePort
k get svc
kubectl exec -it [pod name] -- /bin/bash
cat > /usr/share/nginx/html/index.html
```
### Limit resources
- [Limit resources](./k8_ymls_configs.md)
```bash
k apply -f pod.yml
k describe pod [pod name]
```
