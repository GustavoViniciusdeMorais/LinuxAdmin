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
