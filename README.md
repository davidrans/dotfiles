# dotfiles

## Install
```
git clone --recurse-submodules https://github.com/davidrans/dotfiles.git
sudo apt install stow
cd dotfiles
rm ~/.bashrc
stow bash
stow tmux
stow rg
mkdir -p ~/.local/share/nvim/site/pack/plugins/start
stow neovim
```
## neovim
### Add a new plugin
```
git submodule add https://github.com/github/copilot.vim.git ./neovim/.local/share/nvim/site/pack/plugins/start/copilot.vim
```
