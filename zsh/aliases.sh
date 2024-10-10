# Utility
alias ..='cd ..'
alias cls='clear'

alias vencord='sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"'
alias apps='cd ~/.local/share/applications/'

# SSH
alias louis='ssh anton@192.168.178.48'

# LS
alias ls='ls --color=always -F'
alias la='ls -a'
alias ll='ls -l'

# WG
alias wgon='wg-quick up ~/Downloads/wg0.conf'
alias wgoff='wg-quick down ~/Downloads/wg0.conf'

# nvim
nv() { neovide $1 & }
