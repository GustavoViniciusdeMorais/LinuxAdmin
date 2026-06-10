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
Applies the changes from a specific commit (or commits) to your current branch, creating a new commit with those same changes but a different commit hash.
**When to use:** You need a specific fix/feature from another branch without merging the entire branch
**Key point:** Creates a **new commit** (different hash), doesn't move the original
```bash
git log --oneline | head -3
git cherry-pick <commit-hash-1> <commit-hash-2>  # multiple commits
git push origin master
```
#### Revert commits
```bash
git log --oneline
git reset --hard [hash commit]
git push origin master --force
```
#### Stash
```bash
git stash list
git stash apply --index 1
git status
git commit -m "stash" && git push origin master
```
#### Rebase Master
Get master changes without merge
```bash
git rebase master
git push origin feature -f
```
#### Conflict
```bash
git pull origin master
git config -l | grep user
vi story-index.txt 
git add story-index.txt && git commit -m "merged"
git push origin master
```
#### Config Hook
- [hook.sh](./hook.sh)
```html
The command git rev-parse "$refname" converts a reference name (like refs/heads/master) into the full SHA-1 commit hash it points to.<br>
For example refs/heads/master becomes hash a1b2c3d4e5f6
```
```bash
cd /opt/official.git/hooks
nano post-update # add hook.sh content
chmod +x post-update
cd /repos/official
git log --oneline
git checkout master && git merge feature && git push origin master
cd /opt/official.git/hooks && git tag -l
```
