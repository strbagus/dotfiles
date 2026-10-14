# Dotfiles

Personal configuration files for ThinkPad X1 Carbon Gen 9 running Debian (X11).

## Components

| Component | Tool | Config Path |
|---|---|---|
| Window Manager | i3-gaps | `i3/` → `~/.config/i3` |
| Compositor | picom (GLX + vsync) | `picom/` → `~/.config/picom` |
| Status Bar | polybar | `polybar/` → `~/.config/polybar` |
| App Launcher | rofi | `rofi/` → `~/.config/rofi` |
| Clipboard Manager | greenclip | daemon in i3 (`$mod+c`) |
| Terminal | alacritty | `alacritty/` → `~/.config/alacritty` |
| Multiplexer | tmux | `tmux/` → `~/.config/tmux` |
| Shell | zsh | `zsh/` → `~/.config/zsh` |
| Editor | Neovim | `nvim-v2/` → `~/.config/nvim` |
| Notifications | dunst | `dunst/` |
| System Fetch | fastfetch | `fastfetch/` → `~/.config/fastfetch` |

## Symlinks Setup

```sh
dot_dir="$HOME/Others/dotfiles"

mkdir -p ~/.config

ln -sfn "$dot_dir/alacritty"   ~/.config/alacritty
ln -sfn "$dot_dir/fastfetch"   ~/.config/fastfetch
ln -sfn "$dot_dir/i3"          ~/.config/i3
ln -sfn "$dot_dir/nvim-v2"     ~/.config/nvim
ln -sfn "$dot_dir/picom"       ~/.config/picom
ln -sfn "$dot_dir/polybar"     ~/.config/polybar
ln -sfn "$dot_dir/rofi"        ~/.config/rofi
ln -sfn "$dot_dir/tmux"        ~/.config/tmux
ln -sfn "$dot_dir/zsh"         ~/.config/zsh
ln -sfn "$dot_dir/zsh/.zshenv" ~/.zshenv
```

## Keybindings (i3wm)

- `$mod+Return`: Terminal (`alacritty`)
- `$mod+d`: App launcher (`rofi -show drun`)
- `$mod+c`: Clipboard history (`greenclip` via `rofi`)
- `$mod+q`: Kill focused window
- `$mod+f`: Toggle fullscreen
- `$mod+Shift+space`: Toggle floating
- `$mod+p`: Display menu (`~/Others/dotfiles/scripts/displaymenu.sh i3wm`)
- `$mod+Shift+e`: Power menu (`~/Others/dotfiles/scripts/powermenu.sh i3wm`)
- `$mod+Shift+d`: File manager (`thunar`)
- `$mod+Shift+x`: Lock screen (`light-locker`)
- `$mod+m`: Toggle notification pause (`dunstctl`)
- `Print` / `Shift+Print`: Screenshot (`xfce4-screenshooter`)

## Dependencies & Requirements

- `greenclip`: Place static binary in `~/.local/bin/greenclip`.
- `tpm`: `git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm`
- Tools: `alacritty`, `rofi`, `picom`, `polybar`, `dunst`, `feh`, `light-locker`, `pactl`, `brightnessctl`, `lazygit`, `ripgrep`, `eza`, `bat`, `fd`.
