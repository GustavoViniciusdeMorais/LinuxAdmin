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
---
### Computer Nodes
UI Configs
- manage/pluginManager/available add ssh, ssh credentials and build agents
- manage/credentials/store/system/domain/_/ (tony and pass for ssh)
- manage/computer add node (computer/App_server_1/configure)
  - name is App_server_1
  - remote root dir /home/tony/jenkins
  - labels App_server_1 : stapp01
  - usage: only build jobs with label
  - launch method is ssh: host (stapp01), crendentials (tony), manually trusted host key
  - at status screen click at relaunch button

```bash
ssh tony@stapp01
sudo su
yum update -y
dnf install -y java-17-openjdk -y
alternatives --config java
```
---
### Deploy Pipeline
UI Configs<br>
The pipeline will use the node, so the node label must be stapp01<br>
The dir /tmp/app must not exist to click finish task button<br>
Get the git repo link with Gitea https link to git clone command<br>
- manage/pluginManager/available add ssh, ssh credentials and build agents, Git, Pipeline (usually preinstalled), Publish Over SSH (optional)
- manage/credentials/store/system/domain/_/: add credential for `sarah` (password `Sarah_pass123`) — ID e.g. `sarah-ssh`
- manage/computer/new node (computer/App_Server_1/configure)
  - name: `App Server 1`
  - remote root dir: `/home/sarah/jenkins_agent`
  - labels: `stapp01`
  - usage: only build jobs with label `stapp01`
  - launch method: SSH — host `stapp01`, credentials `sarah-ssh`, manually trusted host key
  - click Save, then on status page click **Relaunch agent**

- New Item → name `nautilus-webapp-job` → type **Pipeline** (NOT Multibranch) → OK
  - Pipeline → Definition: **Pipeline script**
  - Paste:
```groovy
pipeline {
    agent { label 'stapp01' }
    stages {
        stage('Deploy') {
            steps {
                sh "git clone https://3000-port-nbgmhifh3xligy2i.labs.kodekloud.com/sarah/web_app.git /tmp/app"
                sh "cp -r /tmp/app/* /var/www/html"
            }
        }
    }
}
```
  - Save → **Build Now**

```bash
ssh sarah@stapp01
sudo su
yum update -y
dnf install -y java-17-openjdk -y
alternatives --config java
cd /var/www/html && git show -q
```
---
