# Config Web Service, Protect, Scan
- [docker compose file](https://github.com/GustavoViniciusdeMorais/Hacking_Studies/blob/virtual-network/docker-compose.yaml)
- [Apache](./apache.md)
```bash
# 1. Create a user-defined bridge network with a subnet
docker network create --subnet=192.168.100.0/24 mynet

# 2. Run the container with a static IP on that network,
#    and add a host entry so it can reach the local machine
docker run -it -d --name kali \
  --network mynet \
  --ip 192.168.100.50 \
  --add-host=host.docker.internal:host-gateway \
  gustavovinicius/devsecops:parrotsec-security

# The local machine will be the server because iptables
# Build only a container client as follows
docker exec -it -u 0 kali bash

curl --max-time 2 http://host.docker.internal:80
```
### Server
```bash
ping -c 2 archive.ubuntu.com

apt install -y iproute2 iptables iptables-persistent apache2

iptables -L INPUT -n --line-numbers

iptables -D INPUT <number>

iptables -A INPUT -p tcp -s 192.168.100.50 -j DROP

netfilter-persistent save

tshark -i wlp0s20f3 host 192.168.0.50

nmap -sn -T4 192.168.0.0/24
```
### IP Tables
```bash
# Allow local loopback
sudo iptables -A INPUT -i lo -j ACCEPT

# Allow established connections (to prevent SSH disconnection)
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow port 80 only from localhost
sudo iptables -A INPUT -p tcp -s 127.0.0.1 --dport 80 -j ACCEPT

# Drop all other port 80 traffic
sudo iptables -A INPUT -p tcp --dport 80 -j DROP
```
### Scans
```bash
nmap -sV -p 80,8081 host.docker.internal
```
