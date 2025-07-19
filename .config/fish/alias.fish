# Utilities
alias cls 'clear; echo "( .-.)"'

alias vencord 'sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"'

# Places
alias applications 'cd ~/.local/share/applications/'
alias dot 'cd ~/dotfiles'

# Layout
alias smap layout # Switch map
alias us 'layout -t us'
alias sv 'layout -t se'

# SSH
alias louis 'vpn --enable && ssh anton@192.168.178.48'

alias wgon 'echo "$(set_color red)You changed this dimwit, use \'vpn\' instead"'
alias wgoff 'echo "$(set_color red)You changed this dimwit, use \'vpn\' instead"'

# Git
#alias glog 'git log --graph --abbrev-commit --decorate --format=format:\'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)\''
#alias gref 'git show -s --pretty=reference '
alias glog 'git lg'
alias gref 'git ref'

alias disable_webkit 'set -gx WEBKIT_DISABLE_DMABUF_RENDERER 1; set -gx WEBKIT_DISABLE_COMPOSITING_MODE 1'
