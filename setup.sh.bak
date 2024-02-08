echo 'Setup Started'

dot_dir=~/.dotfiles

git clone https://github.com/tmux-plugins/tpm $dot_dir/tmux/plugins/tpm

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
install lazygit /usr/local/bin

apt install ripgrep

apt install zsh

cd $dot_dir/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cd ~

ln -s $dot_dir/tmux ~/.config/tmux
ln -s $dot_dir/nvim ~/.config/nvim
ln -s $dot_dir/i3 ~/.config/i3
ln -s $dot_dir/zsh/zshrc ~/.zshrc

echo 'Finished'
