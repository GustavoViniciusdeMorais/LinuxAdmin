# K8s commands descriptions
**Pod**: The smallest deployable unit in Kubernetes. It runs one or more containers directly. No self-healing, scaling, or updates—if it dies, it's gone.

**Deployment**: A higher-level controller that manages Pods. It provides:
- **Replicas** – runs multiple identical Pods
- **Self-healing** – replaces failed Pods automatically
- **Rolling updates** – updates Pods with zero downtime
- **Scaling** – easily increase/decrease replicas

In short: **Pod is a single instance; Deployment manages Pods for reliability and scale.**

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
