# Apache
**1. Create the new page**
```bash
mkdir -p /var/www/secondpage
tee /var/www/secondpage/index.html > /dev/null <<'EOF'
<h1>Hacking Page</h1>
EOF
```
**2. Add a new VirtualHost (listen on port 8081)**
```bash
tee /etc/apache2/sites-available/secondpage.conf > /dev/null <<'EOF'
<VirtualHost *:8081>
    DocumentRoot /var/www/secondpage
    ErrorLog ${APACHE_LOG_DIR}/secondpage_error.log
    CustomLog ${APACHE_LOG_DIR}/secondpage_access.log combined
</VirtualHost>
EOF
```
**3. Tell Apache to listen on 8081**
```bash
echo "Listen 8081" | tee -a /etc/apache2/ports.conf
```
**4. Enable the site and reload**
```bash
a2ensite secondpage.conf
systemctl reload apache2
```
**5. Test**
```bash
curl http://localhost:8081
```
