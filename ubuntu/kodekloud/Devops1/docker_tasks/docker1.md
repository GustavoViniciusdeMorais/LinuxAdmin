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
#### Copy file to container
```bash
docker cp /tmp/nautilus.txt.gpg ubuntu_latest:/usr/src/
docker exec -it ubuntu_latest ls -lh /usr/src
```
#### Image new tag
```bash
docker tag [image name]:[old tag name] [image name]:[new tag name]
```
#### Create image from container
```bash
docker commit [container name] [new image name]:[new tag]
```
#### Config apache server
```bash
docker exec -it -u 0 kkloud bash
apt update -y && apt install nano apache2 net-tools -y
find /etc/* -type f -name ports*
nano /etc/apache2/ports.conf # 8087
service apache2 start
curl -Ik localhost:8087
```
#### Dockerfile
```yml
FROM ubuntu:24.04
RUN apt update -y && apt install apache2 -y
RUN sed -i.bkp 's/Listen 80/Listen 3002/g' /etc/apache2/ports.conf
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
```
```bash
docker build -t myserver .
docker run -it -d --name test -p 90:3002 myserver:latest
```
#### Create network
```bash
docker network ls
docker network create --help
docker network create --driver macvlan --subnet 172.28.0.0/24 --ip-range 172.28.0.0/24 media
docker network ls | grep media
ocker network inspect media
```
#### Container with port
```bash
docker pull nginx:stable
docker run -it -d --name news -p 3004:80 nginx:stable
curl -Ik stapp03:3004
```
#### Compose
```yml
services:
    httpd:
        image: httpd:latest
        container_name: httpd
        ports:
            - 8087:80
        volumes:
            - /opt/security:/usr/local/apache2/htdocs
```
#### Compose
```bash
mv /opt/security/index1.html /opt/security/index.html
cd /opt/docker/ && nano docker-compose.yml
docker compose up -d --build httpd
```
