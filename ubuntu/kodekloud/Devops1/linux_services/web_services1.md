# Linux Services
### Tomcat Service
```bash
# at jum host
scp /tmp/ROOT.war banner@stapp03:/home/banner

# at app server
yum update -y && yum install tomcat -y
yum install nano -y

systemctl status tomcat
tomcat version

mv ROOT.war /usr/share/tomcat/webapps/

grep -in ".*port.*" /etc/tomcat/server.xml # line 71
nano /etc/tomcat/server.xml
# port=5000
systemctl restart tomcat

curl http://stapp03:5000
```
### Curl Apache httpd service
```bash
# in jump host
curl http://stapp01:8087
# config services in stapp01
systemctl status httpd

ss -ntulp | grep 8087
ls -lh /etc/ | grep mail
cd /etc/mail
ls -lh | grep ".*cf.*"
grep -in ".*port.*" sendmail.cf
# edit line
nano sendmail.cf 
#port=28

systemctl restart sendmail
systemctl restart httpd

iptables -I INPUT -p tcp -s 10.244.164.108 --dport 8087 -j ACCEPT
iptables -L

systemctl status iptables
```
### Config Iptables all app hosts
```bash
# get ip of LBR host
ifconfig
# On every app server
yum update -y && yum install iptables -y && yum install iptables-services -y

systemctl enable iptables
systemctl start iptables
systemctl status iptables

iptables -A INPUT -p tcp -s stlb01 --dport 8088 -j ACCEPT
iptables -A INPUT -p tcp --dport 8088 -j DROP
# delete rule number if needed
iptables -D INPUT 5
iptables -L INPUT --line-numbers -n -v

iptables-save > /etc/sysconfig/iptables

systemctl restart iptables

# at load balancer host
curl -m 5 stapp02:8088
```
### Linux process troubleshooting
```bash
curl -m 5 stapp01:3001
# at server
ss -ntulp | grep 3001
systemctl status httpd -l
ls -lh /etc/ | grep mail
cd /etc/mail
ls -lh | grep ".*cf.*"
grep -in ".*port.*" sendmail.cf
# edit line
nano sendmail.cf
#port=28

systemctl restart sendmail
systemctl restart httpd
```
### Linux NGINX SSL Config
```bash
yum update -y && yum install nginx -y
systemctl start nginx

cd /etc/nginx && grep -in ".*server.*" nginx.conf
grep -in ".*root.*" nginx.conf
echo "Welcome!" > /usr/share/nginx/html/index.html
# there is ssl config infos in nginx.conf

mkdir certs && cd certs
cp /tmp/nautilus.crt server.crt
cp /tmp/nautilus.key server.key
# add the ssl config in nginx /etc/nginx/certs
nginx -t
systemctl restart nginx
# at client
curl -Ik https://stapp03
```
### Nginx Load Balance
```bash
# discover the service port at app host
grep ".*Listen.*" /etc/httpd/conf/httpd.conf

# config nginx at load balance host
yum update -y && yum install nginx -y

systemctl start nginx

nano /etc/nginx/nginx.conf
# add the upstream configs
nginx -t

systemctl restart nginx

# at jum host
curl -Ik http://stlb01:80
```
#### Nginx upstream config
```json
http {
    upstream app_servers {
        server stapp01:3004;
        server stapp02:3004;
        server stapp03:3004;
    }
    server {
        location / {
            proxy_pass http://app_servers;
        }
    }
}
```
### Config PostgreSQL
```bash
# in database server
grep ".*postgre.*" /etc/passwd
sudo -u postgres psql
CREATE USER kodekloud_aim WITH PASSWORD '';
CREATE DATABASE kodekloud_db10;
GRANT ALL PRIVILEGES ON DATABASE kodekloud_db10 TO kodekloud_aim;
```
