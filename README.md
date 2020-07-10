# dotfiles

## Install
```
git clone --recurse-submodules https://github.com/davidrans/dotfiles.git
sudo apt install stow
cd dotfiles
rm ~/.bashrc
stow bash
stow vim
stow tmux
```
## vim
### Add a new plugin
```
git submodule add https://github.com/leafgarland/typescript-vim.git vim/.vim/pack/plugins/start/typescript-vim
```
