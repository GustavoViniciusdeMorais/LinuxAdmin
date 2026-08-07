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
    command: ["sh", "-c", "while true; do cat /var/log/nginx/access.log /var/log/nginx/error.log; sleep 30; done"]
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
### Persist volumes
```bash
k apply pod.yml
k get pv,pvc,pod,svc
```
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-datacenter
spec:
  capacity:
    storage: 5Gi
  accessModes:
    - ReadWriteOnce
  storageClassName: manual
  hostPath:
    path: /mnt/finance
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-datacenter
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 3Gi
  storageClassName: manual
---
apiVersion: v1
kind: Pod
metadata:
  name: pod-datacenter
  labels:
    app: pod-datacenter
spec:
  containers:
    - name: container-datacenter
      image: httpd:latest
      volumeMounts:
        - mountPath: /usr/local/apache2/htdocs
          name: data-volume
  volumes:
    - name: data-volume
      persistentVolumeClaim:
        claimName: pvc-datacenter
---
apiVersion: v1
kind: Service
metadata:
  name: web-datacenter
spec:
  type: NodePort
  selector:
    app: pod-datacenter
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30008
```
### Deployment, replicaset, init container, main container, shared volume, containers commands
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ic-deploy-devops
  labels:
    app: ic-devops
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ic-devops
  template:
    metadata:
      labels:
        app: ic-devops
    spec:
      initContainers:
      - name: ic-msg-devops
        image: fedora:latest
        command: ["/bin/bash", "-c", "echo Init Done - Welcome to xFusionCorp Industries > /ic/ecommerce"]
        volumeMounts:
          - name: ic-volume-devops
            mountPath: /ic
      containers:
      - name: ic-main-devops
        image: fedora:latest
        command: ["/bin/bash", "-c", "while true; do cat /ic/ecommerce; sleep 5; done"]
        volumeMounts:
          - name: ic-volume-devops
            mountPath: /ic
      restartPolicy: Always
      volumes:
        - name: ic-volume-devops
          emptyDir: {}
```
### Pod to read from secret volume
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-devops
spec:
  containers:
  - name: secret-container-devops
    image: fedora:latest
    command: ["sleep", "3600"]
    volumeMounts:
    - name: secret-volume
      mountPath: /opt/games
      readOnly: true
  volumes:
  - name: secret-volume
    secret:
      secretName: official
```
