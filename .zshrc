# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
# export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="robbyrussell"

# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# plugins=(
# 	git
# 	zsh-syntax-highlighting
# 	# zsh-autosuggestions
# 	zsh-autocomplete
# 	colored-man-pages
# 	sudo
# )


# source $ZSH/oh-my-zsh.sh

# ZInit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# fzf
source <(fzf --zsh)

zinit snippet OMZ::lib/git.zsh

[ -f ~/zsh/aliases.sh ] && source ~/zsh/aliases.sh
[ -f ~/zsh/functions.sh ] && source ~/zsh/functions.sh
[ -f ~/zsh/prompt.sh ] && source ~/zsh/prompt.sh
[ -f ~/zsh/completion.sh ] && source ~/zsh/completion.sh


# Path
PATH+=":/home/anton/Rider/bin"

zinit ice wait'!0'

[ -f ~/zsh/plugins.sh ] && source ~/zsh/plugins.sh

# source ${ZINIT_HOME}/../plugins/marlonrichert---zsh-autocomplete/zsh-autocomplete.plugin.zsh
# zstyle ':autocomplete:*' delay 0.1  # seconds (float)
