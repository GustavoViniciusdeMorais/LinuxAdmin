# Kubernetes config files
### Simple pod
nano pod.yml
```yml
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: httpd_app
  name: pod-httpd
spec:
  containers:
  - image: httpd:latest
    name: httpd-container
```
### Limit resources
```yml
apiVersion: v1
kind: Pod
metadata:
  name: httpd-pod
spec:
  containers:
  - name: httpd-container
    image: httpd:latest
    resources:
      requests:
        memory: "15Mi"
        cpu: "100m"
      limits:
        memory: "20Mi"
        cpu: "100m"
```
### Shared volume
```yml
apiVersion: v1
kind: Pod
metadata:
  name: volume-share-devops
spec:
  containers:
  - name: volume-container-devops-1
    image: debian:latest
    command: ["sleep", "360000"]
    volumeMounts:
      - name: volume-share
        mountPath: /tmp/news
  - name: volume-container-devops-2
    image: debian:latest
    command: ["sleep", "360000"]
    volumeMounts:
      - name: volume-share
        mountPath: /tmp/demo
  volumes:
    - name: volume-share
      emptyDir: {}
```
### Sidecar Container
```yml
apiVersion: v1
kind: Pod
metadata:
  name: webserver
spec:
  initContainers:
  - name: sidecar-container
    image: ubuntu:latest
    restartPolicy: Always
    command: ["sh", "-c", "while true; do cat /var/log/nginx/access.log /var/log/nginx/error.log; sleep >
    volumeMounts:
      - name: shared-logs
        mountPath: /var/log/nginx
  containers:
  - name: nginx-container
    image: nginx:latest
    volumeMounts:
      - name: shared-logs
        mountPath: /var/log/nginx
  volumes:
    - name: shared-logs
      emptyDir: {}
```
