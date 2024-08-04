# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-syntax-highlighting
	# zsh-autosuggestions
	zsh-autocomplete
	sudo
)

zstyle ':autocomplete:*' delay 0.1  # seconds (float)

# completions
# ZSH_AUTOSUGGEST_STRATEGY=(
# 	history
# 	completion
# )
#
# # Remove forward-char widgets from ACCEPT
# ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=("${(@)ZSH_AUTOSUGGEST_ACCEPT_WIDGETS:#forward-char}")
# ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=("${(@)ZSH_AUTOSUGGEST_ACCEPT_WIDGETS:#autosuggest-accept}")
#
# # Add forward-char widgets to PARTIAL_ACCEPT
# ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(autosuggest-accept)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# fzf
source <(fzf --zsh)

alias ..='cd ..'
alias cls='clear'
alias explorer='nautilus'
alias vencord='sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"'
alias apps='cd ~/.local/share/applications/'
alias tasklist='ps -aux'
alias louis='ssh anton@192.168.178.48'
alias la='ls -a --color=auto'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
# WG
alias wgon='wg-quick up ~/Downloads/wg0.conf'
alias wgoff='wg-quick down ~/Downloads/wg0.conf'

# Very helpful multi-functional clip command.
clip() {
  if [ -t 0 ]; then
    # Standard input is not a terminal (no pipe input)
    if [ $# -eq 0 ]; then
      # No arguments, print clipboard content
      xclip -selection clipboard -o
    else
      # Arguments provided, pass them to xclip
      echo "$*" | xclip -selection clipboard
    fi
  else
    # Standard input is a terminal (pipe input)
    xclip -selection clipboard
  fi
}
# copy text
# $ clip "hello world"
# copy cmd output
# $ cat file.js | clip
# use copied data as values, for example run a script off the clipboard
# $ clip | python3 # runs what's in the clipboard using python3

into() {
	mkdir -p "$1" && cd "$1";
}

# Custom theme
PROMPT=""

# Arrow
PROMPT+="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg[red]%}%? %{$fg_bold[red]%}%1{➜%} )"

# Path
PROMPT+="%{$fg[cyan]%}%c%{$reset_color%} "

# Git
PROMPT+='$(git_prompt_info)'

# This stuff is imported from the actual Robbyrussell theme.
# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# Function to capture the start time of the command
preexec() {
    timer_start=$EPOCHSECONDS
}

# Function to capture the end time of the command and calculate the elapsed time
precmd() {
    local timer_end=$EPOCHSECONDS
    local elapsed=$((timer_end - timer_start))
    
    # Reset RPROMPT
    RPROMPT=""

	if (( elapsed > 36000 )); then
		return
	fi

    if (( elapsed > 0 )); then
        local color time_str
        if (( elapsed >= 60 )); then
            local minutes=$((elapsed / 60))
            local seconds=$((elapsed % 60))
            time_str="${minutes}m ${seconds}s"
            color="%{$fg_bold[red]%}"
        elif (( elapsed >= 10 )); then
            time_str="${elapsed}s"
            color="%{$fg_bold[blue]%}"
        elif (( elapsed >= 5 )); then
            time_str="${elapsed}s"
            color="%{$fg_bold[yellow]%}"
        elif (( elapsed >= 1 )); then
            time_str="${elapsed}s"
            color="%{$fg_bold[green]%}"
        fi

        # Set RPROMPT if elapsed time is greater than or equal to 1 second
        if [[ -n $time_str ]]; then
            RPROMPT="${color}${time_str}%{$reset_color%}"
        fi
    fi
}
