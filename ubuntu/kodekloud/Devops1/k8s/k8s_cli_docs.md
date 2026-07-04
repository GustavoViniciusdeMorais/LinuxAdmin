# K8s commands descriptions

**`k create deploy nginx --image nginx:latest`**
Creates a Deployment named "nginx" that runs the `nginx:latest` container image. This automatically creates a ReplicaSet and Pod(s) to ensure the desired number of replicas (default: 1) are always running.

**`k get rs`**
Lists all ReplicaSets in the current namespace. A ReplicaSet ensures a specified number of pod replicas are running at any given time. The Deployment you just created will have automatically generated one.

**`k get svc`**
Lists all Services. Services provide stable networking endpoints to access your pods. At this point, you likely won't see anything unless you've explicitly created a Service for the nginx Deployment.

**`k get pods`**
Lists all Pods. You should see your nginx pod(s) running here, showing their status (Running, ContainerCreating, etc.), age, and other details.

**`k expose deploy nginx --port 80 --target-port 80 --type NodePort`**
Creates a Service that exposes the "nginx" Deployment on port 80. It maps the Service's port 80 (`--port`) to the container's port 80 (`--target-port`). With `--type NodePort`, it opens a high-numbered port (30000-32767) on every node, making the app accessible externally via `<NodeIP>:<NodePort>`.