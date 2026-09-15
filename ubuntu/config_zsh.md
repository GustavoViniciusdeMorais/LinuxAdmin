# Config ZSH
### Install
```bash
apt update -y
apt install zsh -y

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

chsh -s $(which zsh)
source /root/.zshrc
omz update
```
### Enter Oh My Zsh
```bash
zsh
omz update
exit
```
### Add the aliases
Add in the end of file /root/.zshrc
```bash
nano /root/.zshrc
source /root/.zshrc
# content for end of /root/.zshrc
alias tlp='netstat -tlp'
alias mybranch='git branch --show-current'
alias myowner='chown -R gustavo:gustavo ./'
```
