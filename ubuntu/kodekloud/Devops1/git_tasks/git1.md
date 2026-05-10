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
#### Merge Branches
```bash
cd /usr/src/kodekloudrepos/beta && git checkout -b datacenter master
git remote show origin
cp /tmp/index.html .
git add index.html && git commit -m "added index"
git checkout master && git merge datacenter
git push origin datacenter
git push origin master
```
#### Manage Remotes
```bash
cd /usr/src/kodekloudrepos/ecommerce
git remote add [remote name] /url or /path
git remote -v
cp /tmp/index.html .
git add index.html && git commit -m "added index"
git push [remote name] [branch name]
```
#### Revert Changes
Keeping notes simple, just main commands
```bash
git log --oneline | head -3
# can do git checkout [hash commit] and see the files
# then git checkout main again
git revert HEAD
```
#### Cherry Pick
```bash
git log --oneline | head -3
git cherry-pick [commit hash]
git push origin master
```
