# Config irc server
```bash
apt install ngircd -y
nano /etc/ngircd/ngircd.conf
service ngircd start
apt install iproute2 -y

# at alpine
apk update
apk add irssi
irssi -c 11.0.0.8 -n gustavo
/join #general
```
### docker-compose.yml
```yml
services:
    server:
        build:
          context: .
          dockerfile: ubuntu.dockerfile
        container_name: server
        ports:
            - 6667:6667
            - 80:80
        volumes:
            - ./:/code
        networks:
            stddocker-app-network:
                ipv4_address: 11.0.0.8
    
    client:
      build:
          context: .
          dockerfile: alpine.dockerfile
      container_name: client
      networks:
            stddocker-app-network:
                ipv4_address: 11.0.0.9

networks:
    stddocker-app-network:
        driver: bridge
        ipam:
            driver: default
            config:
                - subnet: "11.0.0.0/16"
```
### docker files
```dockerfile
# ubuntu server
FROM gustavovinicius/ubuntu_server_light:may2026
ENTRYPOINT ["tail", "-f", "/dev/null"]

# alpine client
FROM alpine:latest
ENTRYPOINT ["tail", "-f", "/dev/null"]
```
