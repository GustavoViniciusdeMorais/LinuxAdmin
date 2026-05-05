# Linux 1 Advanceds
### SSH (scp) Copy file to server
```bash
scp /tmp/nautilus.txt.gpg steve@stapp02:/home/web
```
### crontab access
```bash
echo "user1name" >> /etc/cron.deny
echo "user2name" >> /etc/cron.allow
```
### gui booting default
```bash
systemctl get-default
ls -lh /etc/systemd/system | grep -i ".*graph.*"
systemctl set-default graphical.target
```
### Config timezone
```bash
timedatectl
timedatectl list-timezones | grep "Asia/Kathmandu"
timedatectl set-timezone Asia/Kathmandu
```
### Firewalld
```bash
yum update -y && yum install net-tools -y && yum install firewalld -y
systemctl start firewalld
firewall-cmd --zone=public --add-port=8086/tcp --permanent
firewall-cmd --reload
firewall-cmd --zone=public --list-ports
curl -Ik localhost:8086
```
### Limit user qty number processes
```bash
grep nfsuser /etc/passwd
nano /etc/security/limits.conf
# in file add lines
nfsuser soft nproc 1026
nfsuser hard nproc 2024

sudo -u nfsuser ulimit -u
```
### Linux Test 1
```bash
grep -v "code" /home/BSD.txt > /home/BSD_DELETE.txt

sed 's/\bfrom\b/them/g' /home/BSD.txt > /home/BSD_REPLACE.txt

yum update -y && yum install sqlite -y
sqlite3
.exit

yum list installed | grep logrot
yum remove logrotate -y
```
