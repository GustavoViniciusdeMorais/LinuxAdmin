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
                sh '''
                rm -rf /tmp/app
                git clone https://3000-port-o7t6plnxgnvqtv2q.labs.kodekloud.com/sarah/web_app.git /tmp/app
                rm -rf /var/www/html/*
                cp -r /tmp/app/* /var/www/html/
                '''
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
chown -R sarah:sarah /var/www/html
cd /var/www/html && git show -q
# jenkins
ssh jenkins@jenkins
jenkins --version
```
---
### Conditional Pipeline
Use the same bash instructions as previous.
```groovy
pipeline {
    agent { label 'stapp01' }
    parameters {
        string(name: 'BRANCH', defaultValue: 'master', description: 'Branch to deploy')
    }
    stages {
        stage('Deploy') {
            steps {
                sh """
                cd /var/www/html
                git fetch origin
                git clean -fd
                git checkout -f ${params.BRANCH}
                git reset --hard origin/${params.BRANCH}
                """
            }
        }
    }
}
```
---
### Git push Pipeline
##### Recommended: Freestyle job
UI Configs
- manage/pluginManager/available: install **Git**, **Gitea**, **Generic Webhook Trigger**, **SSH Build Agents**, **Credentials** — restart Jenkins
- manage/credentials/store/system/domain/_/: add `sarah` / `Sarah_pass123` (ID `sarah-gitea`)
- manage/computer/new node (computer/App_Server_1/configure)
  - name: `App Server 1`
  - remote root dir: `/home/sarah/jenkins_agent`
  - labels: `stapp01`
  - usage: only build jobs with label `stapp01`
  - launch: SSH — host `stapp01`, credentials `sarah`, manually trusted host key
  - Save → **Relaunch agent**

- New Item → `devops-app-deployment` → **Freestyle project** → OK
  - **Restrict where this project can be run**: `stapp01`
  - **Triggers**: Generic Webhook Trigger
    - Token: gustavo
  - **Build Environment**: none
  - **Build Steps** → **Execute shell**:

```bash
cd /home/sarah/web
git fetch origin
git checkout master
git reset --hard origin/master
echo 'Sarah_pass123' | sudo -S cp -a /home/sarah/web/. /var/www/html/
echo 'Sarah_pass123' | sudo -S systemctl restart httpd
```
  - Save

###### Fixed with webhook
```
Add plugin of name Generic Webhook Trigger Plugin
In the job configurations, select trigger
add the token of name gustavo

In Gitea Webhook add the webhook of tipe gitea
Link is
https://8080-port-67u4mnoazaztq434.labs.kodekloud.com/generic-webhook-trigger/invoke?token=gustavo
```

###### Or With admin token
- Create api token:
  - Manage Jenkins > Users > Admin > Security
  - Generate API Token

- Create a freestyle job for deployment:
  - name: nautilus-app-deployment
  - Trigger: Build trigger remotely:
    - BUILD TOKEN: kodekloud, anything you like

```
job token: kodekloud
admin token: 111ee080c6e780d5ae756c8a2f13f51fb4

https://admin:111ee080c6e780d5ae756c8a2f13f51fb4@8080-port-oowntrnv4ainpjen.labs.kodekloud.com/job/datacenter-app-deployment/build?token=kodekloud
```

###### Test pipeline
```bash
# On stapp01 as sarah
chown -R sarah:sarah /var/www/html
chown -R sarah:sarah /home/sarah/web
git config --global user.email "sarah@stratos.xfusioncorp.com"
git config --global user.name "sarah"
yum install rsync -y
cd /home/sarah/web
echo "Welcome to the xFusionCorp Industries" > index.html
git add index.html
git commit -m "update index"
git push origin master
```
---
### Chained jobs
- Create a job to execute shell
- Access job configuration => Post build actions => type the name of the job
```bash
# first job
sshpass -p '' ssh -o StrictHostKeyChecking=no tony@stapp01 -p 22 \
"cd /var/www/html && git pull origin master"
# sec job
sshpass -p '' ssh -o StrictHostKeyChecking=no tony@stapp01 -p 22 \
"echo 'pass' | sudo -S systemctl restart httpd"
```
---
