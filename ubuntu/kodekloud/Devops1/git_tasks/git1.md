## Git tasks
### Git bare dir
```bash
# ssh storage host
yum update -y && yum install git -y

mkdir /opt/blog.git && cd /opt/blog.git
git init --bare
git branch -m main
git branch --show-current
ls -lha
git rev-parse --is-bare-repository

cd /home/ && git clone /opt/blog.git && cd blog
git config --global user.name "test"
git config --global user.email "test@info.com"
touch test.txt
git add test.txt && git commit -m "test" && git push origin main
```
#### Clone
```bash
cd /usr/src/kodekloudrepos/
git clone /opt/beta.git/
```
#### Create Branches
```bash
git checkout master && git pull
git checkout -b xfusioncorp_cluster master
git remote show origin
git remote -v
git add .
git commit -m "-test"
git push --set-upstream origin xfusioncorp_cluster
```
