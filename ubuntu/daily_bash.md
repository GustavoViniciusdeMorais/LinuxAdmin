# Daily Bash Linux CLI

```bash
mkdir api
cd api
touch index.php
chown -R gustavo:gustavo ./
chmod u+x index.php

tree .
ls -lh ./ | head -3

find / -type f -name bash_profile >> debug.txt &
find / -type f -regex ".*users.*" 2>/dev/null
grep -in 'word.*' $filepath # . is any char and * is as many
grep -in '.*product.*' $(grep -rl product src/)
ls -lh api/src/controllers/* | grep -i 'user.*'

ssh-keygen -t ed25519 -C "gustavo@email.com"
eval "$(ssh-agent -s)"
ssh-add /root/.ssh/id_hack
ssh-add -l # list the loaded key by the agent
ssh-add -D
ssh gustavo@[ip] -p [port]

wc -l src/api.php

cat api.php | awk 'NR==3' | awk '{print $2}'

ss -ntlp | grep ssh

php process.php >> debug.txt &
jobs
kill -9 %1

tail -f debug.txt

alias | grep my

free -lh

ps aux | sort -nrk 4 | head -4

df -h | head -5
du -sh /home/gustavo/* | sort -rnk 1 | head -2

[ ! -d backup1 ] && echo "dir not exists" || echo "is dir"

for item in $(ls); do if [ -d $item ];then cd $item && pwd && ls -lh && cd ..; fi done
```
