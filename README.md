# Linux Admin

- [Daily Bash](./ubuntu/daily_bash.md)
- [UserGroups](./ubuntu/user_groups.md)
- [CronJob](./ubuntu/cronjob.md)
- [Files and Directories](./ubuntu/files_directories.md)
- [Ssh agent client](./ubuntu/ssh.md)
- [Process Management](./ubuntu/process_management.md)
- [Alias commands](./ubuntu/alias.md)
- [Admin tips](./ubuntu/linux_commands.md)
- [Kungfu commands](./ubuntu/kungfu.md)
- [Networking](./ubuntu/networking.md)

## KodeKloud Devops
- [lfcs essential cli](./ubuntu/lfcs_admin/essential_commands.md)
- [kodekloud main](./ubuntu/kodekloud/kodekloudmain.md)
- [Ansible tutorials](./ubuntu/ansible/doc1.md)

### Add current user permission to files in the folder
```sh
sudo chown -R $USER:$USER .
```
### Search for text inside files
```sh
sudo grep -iR "needle" path/
```
### Manage services start at boot
```sh
systemctl list-unit-files | grep ollama
systemctl disable ollama.service
```
### Hardware infos
```sh
cat /proc/cpuinfo | head
free -lh
df -H
```
### tar zip unzip
```bash
tar -cvf hacking_current.tar --exclude='vendor' ../Studies/Hacking/*
tar -xvf hacking_current.tar # extract
tar -t -f site.tar # show tar contents
tar -x -O -f images/parrot_2.tar manifest.json | jq .
```
### Nice letters
```bash
apt install figlet -y
figlet LINUX
```
### Color cli
```bash
echo -e "\e[34m" # colors ansi code
# echo -e "\e[0m" # reset
```
