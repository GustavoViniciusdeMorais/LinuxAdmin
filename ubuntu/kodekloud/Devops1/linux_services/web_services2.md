## Web Services
### Install LAMP (Linux, Apache, MySQL, PHP)
This task is for later on
```bash
yum update -y && yum install httpd php php-mysqlnd php-fpm -y
sed -i.bkp 's/Listen 80/Listen 8085/g' /etc/httpd/conf/httpd.conf
cat /var/www/html/index.php
systemctl start httpd
# at db server install db server as follow tutorial
# the php script will connect
```
### Config MariaDB
```bash
yum update -y && yum install mariadb-server -y
systemctl enable mariadb.service
mysql_secure_installation
mysql -u root -p
CREATE DATABASE kodekloud_db10;
CREATE USER 'kodekloud_rin'@'localhost' IDENTIFIED BY 'BruCStnMT5';
GRANT ALL PRIVILEGES ON kodekloud_db10.* TO 'kodekloud_rin'@'localhost' IDENTIFIED BY 'BruCStnMT5';
FLUSH PRIVILEGES;
```
### Config Sample WebPages Apache
```bash
# at jump host
scp -r news steve@stapp02:/home/steve/
curl -L http://stapp02:8083/news
# at app host
yum update -y && yum install httpd -y
sed -i.bkp 's/Listen 80/Listen 8083/g' /etc/httpd/conf/httpd.conf
systemctl restart httpd
mv * /var/www/html/
```
### PHP Nginx
```bash
yum update -y && yum install nginx -y

# Install EPEL and Remi repositories
dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
dnf install -y https://rpms.remirepo.net/enterprise/remi-release-9.rpm

# Reset PHP module and enable Remi's PHP 8.3
dnf module reset php -y
dnf module enable php:remi-8.3 -y

# Install PHP 8.3 and FPM
dnf install -y php php-cli php-fpm php-mysqlnd php-gd php-xml php-mbstring
php -v

systemctl enable --now php-fpm

grep -in ".*listen.*" /etc/php-fpm.d/www.conf
nano /etc/php-fpm.d/www.conf
# change the line 38 to
listen = /var/run/php-fpm/default.sock

systemctl start php-fpm

nano /etc/nginx/nginx.conf

nginx -t && systemctl reload nginx

# at jump host
curl http://stapp01:8099/index.php
```

### Nginx Configs
```json
http {
    server {
        listen 8099;
        listen [::]:8099;
        server_name _;
        root /var/www/html;
        index index.html index.php info.php

        location ~ \.php$ {
            fastcgi_split_path_info ^(.+\.php)(/.+)$;
            fastcgi_pass unix:/var/run/php-fpm/default.sock;
            fastcgi_index index.php;
            include fastcgi.conf;
        }
    }
}
```
