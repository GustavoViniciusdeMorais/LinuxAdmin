## Docker tasks
### Install and config
- Browse search for docker enginer or ce.
- [Link in 2026](https://docs.docker.com/engine/install/centos/)
```bash
yum update y && dnf -y install dnf-plugins-core
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
systemctl enable --now docker
systemctl start docker
docker ps
docker compose --help
docker run hello-world
```
#### Nginx Alpine Image Run
```bash
docker ps
docker image ls
docker pull nginx:alpine
docker run -it -d --name nginx_2 -p 81:80 nginx:alpine
curl localhost:81
docker ps
```
