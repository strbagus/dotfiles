# How to Setup
- create sysmlink for each configuration into `~/.config`
- example: `ln -s ~/.dotfiles/nvim ~/.config/nvim`
- for **zsh** `ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc`
- for **wezterm** `ln -s ~/.dotfiles/wezterm/westerm.lua ~/.wezterm`

## I3wm
with polybar

## Neovim 
required version: `0.9^`

**Additional Package:**
- [lazygit](https://github.com/jesseduffield/lazygit) -> git cli ui, integration within Neovim
- [ripgrep](https://github.com/BurntSushi/ripgrep) -> fuzy finding, integration within Neovim
- `npm install -g @vue/language-server @vue/typescript-plugin` -> for vue develompent

## Tmux
Step to install [tpm](https://github.com/tmux-plugins/tpm) plugins:
- `git clone https://github.com/tmux-plugins/tpm /path/to/dotfiles/tmux/plugins/tpm`
- Open tmux, then press: `prefix + I` for install plugins

# Wezterm
How to Install [Wezterm](https://wezfurlong.org/wezterm/installation.html)

## ZSH
Step to install:
- make sure **zsh** is installed. `apt install zsh`
- `cd /path/to/dotfiles/zsh`
- `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

**Extra:** If **.zshrc** already exists when setup **oh-my-zsh**, it will backup existence **.zshrc** into **.zshrc.preload-something**. In order to use older **.zshrc**:
- remove new **.zshrc**: `rm .zshrc`
- rename **.zshrc.preload-something** to **.zshrc**: `mv .zshrc.preload-something .zshrc`
