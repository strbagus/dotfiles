# How to Setup
1. Make sure `zsh & git` are installed.

2. Clone Repository:
```sh
# using ssh
git clone git@github.com:strbagus/dotfiles ~/.dotfiles

# or using http
git clone https://github.com/strbagus/dotfiles ~/.dotfiles
```

3. Create Symlink:
```sh
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/nvim/ ~/.config/nvim/
ln -s ~/.dotfiles/tmux/ ~/.config/tmux/
```

*todo:* make script to run all in one