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
