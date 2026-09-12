# CI CD With Jenkins
### Install
```bash
ssh root@jenkins
cat /etc/*release*
# add jenkins repo following 
# (https://www.jenkins.io/doc/book/installing/linux)
apt update -y
apt install fontconfig openjdk-21-jre -y
wget -h

wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
apt update
apt install jenkins -y
service jenkins status

cat /var/lib/jenkins/secrets/initialAdminPassword
# The next steps are in the jenkins UI

```
### Job Install Package
```bash
# UI create the $PACKAGE variable for the job
sshpass -p '' ssh -o StrictHostKeyChecking=no natasha@ststor01 echo " 'password' | sudo -S yum install -y $PACKAGE"
```
### CronJob Logs
```bash
ssh jenkins@jenkins

ssh-keygen -t rsa
cat .ssh/id_rsa.pub

ssh-copy-id banner@stapp03
ssh-copy-id natasha@ststor01
# just test ssh
ssh banner@stapp03

# UI create job type SCM
# cron time */12 * * * *
scp banner@stapp03:/var/log/httpd/access_log .
scp banner@stapp03:/var/log/httpd/error_log .

scp access_log error_log natasha@ststor01:/usr/src/devops
```
### Job Backup DB SQL
```bash
# generate ssh-key again as previous tutorial
ssh-copy-id natasha@ststor01
# schedule time is */10 * * * *
# job commands are:
ssh tony@stapp01 \
"mysqldump -u kodekloud_roy --password=asdfgdsd kodekloud_db01" \
> db_$(date +%F).sql

scp db_$(date +%F).sql natasha@ststor01:/home/natasha/db_backups

```
