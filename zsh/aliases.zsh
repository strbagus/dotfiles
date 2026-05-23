# Better ls
alias ls='eza --icons'

# Detailed listing
alias ll='eza -lh --icons --git'

# Detailed listing including hidden files
alias la='eza -lah --icons --git'

# Tree view
alias tree='eza --tree --icons'

# Reuse ls completions for eza (avoids defining a separate completion function)
compdef eza=ls

# Better cat
alias cat='bat'

# =========================================================
# Core utilities
# =========================================================

alias grep='rg --color=auto'
alias diff='diff --color=auto'
alias df='df -h'


alias vim='nvim'
# alias pa="php artisan"
# alias pat="php artisan tenants:artisan '$1 --path=database/migrations/tenant --database=tenant'"
# alias phpkey='php -r "echo md5(uniqid()).\"\n\";"'

# Sync Notes
alias psnote='rsync -avzP --delete-after ~/Documents/Notes rpi:data'
alias plnote='rsync -avzP --delete-after rpi:data/Notes ~/Documents/'

# TMUX
alias tn="tmux new -s $1"
alias ta="tmux attach"
alias tkv="tmux kill-server"
alias tks="tmux kill-session"

# TLP
alias tlps="sudo tlp setcharge 75 80 BAT0"
alias tlpf="sudo tlp setcharge 96 100 BAT0"

# Python
alias py="python3"
alias pvm="source $HOME/venv/bin/activate"

alias :q="exit"
# alias mcrcon="mcrcon -H xxx.xxx.xxx.xxx -P 25575 -p pass $1"
