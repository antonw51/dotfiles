# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode reminder  # just remind me to update when it's time

plugins=(
	git
	zsh-syntax-highlighting
	# zsh-autosuggestions
	zsh-autocomplete
	colored-man-pages
	sudo
)

zstyle ':autocomplete:*' delay 0.1  # seconds (float)

source $ZSH/oh-my-zsh.sh

# fzf
source <(fzf --zsh)

[ -f ~/zsh/aliases.sh ] && source ~/zsh/aliases.sh
[ -f ~/zsh/functions.sh ] && source ~/zsh/functions.sh

# Custom theme
PROMPT=""

# Path
PROMPT+="%{$fg[cyan]%}%c%{$reset_color%} "

# Arrow
PROMPT+="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg[red]%}%? %{$fg_bold[red]%}%1{➜%} )"

# Git
PROMPT+='$(git_prompt_info)'
