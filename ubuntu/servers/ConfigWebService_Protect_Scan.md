# Config Web Service, Protect, Scan
- [docker compose file](https://github.com/GustavoViniciusdeMorais/Hacking_Studies/blob/virtual-network/docker-compose.yaml)
```bash
docker run -it -d --name webserver -p 83:80 -p 1080:1080 --network=host --dns 8.8.8.8 --dns 1.1.1.1 gustavovinicius/ubuntu_server_light:may2026

docker exec -it -u 0 webserver bash

ping -c 2 archive.ubuntu.com

apt install iproute2 -y
apt install iptables -y
apt install iptables-persistent -y
apt install apache2 -y

iptables -L INPUT -n --line-numbers

iptables -D INPUT <number>

netfilter-persistent save

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
nmap -sV -p 80 [ip]
```
