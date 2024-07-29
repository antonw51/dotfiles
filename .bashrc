#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

roundseconds () {
  echo m=$1";h=0.5;scale=4;t=1000;if(m<0) h=-0.5;a=m*t+h;scale=3;a/t;" | bc
}

# Function to get the start time in nanoseconds
bash_getstarttime () {
  date +%s.%N > "/dev/shm/${USER}.bashtime.${1}"
}

bash_getstoptime () {
  local endtime=$(date +%s.%N)
  local starttime=$(cat /dev/shm/${USER}.bashtime.${1})
  local duration=$(roundseconds $(echo $(eval echo "$endtime - $starttime") | bc))

  # Only return time if duration is greater than 0.2 seconds
  if (( $(echo "$duration > 0.2" | bc -l) )); then
    echo "took ${duration}s"
  else
    echo ""
  fi
}

parse_git_branch() {
    git branch 2>/dev/null | grep '^*' | colrm 1 2
}

# Initialize the root PID and start time
ROOTPID=$BASHPID
bash_getstarttime $ROOTPID

# Set PS0 to record the start time
PS0='$(bash_getstarttime $ROOTPID)'

prompt_command() {
    local exec_time=$(bash_getstoptime $ROOTPID)
    if [[ -n "$exec_time" ]]; then
        PS1='\[\033[36m\]'"$exec_time"'\n'
    else
        PS1=''
    fi

    PS1+='\[\e[1;32m\]\u\[\e[0m\]@\[\e[1;94m\]\h \[\e[1;95m\]\w\[\e[1;33m\]$([[ $(parse_git_branch) ]] && echo " [$(parse_git_branch)]")\[\e[0m\]'

    #h that's what I was tYu Add virtual environment if exists
    if [[ -n "$VIRTUAL_ENV" ]]; then
        PS1+="\[\e[1;35m\]($(basename $VIRTUAL_ENV)) \[\e[0m\]"
    fi

    # Root indicator
    if [[ $EUID -eq 0 ]]; then
        PS1+="\[\e[1;31m\]# \[\e[0m\]"
    else
        PS1+="\[\e[0;0m\]\$ \[\e[0m\]"
    fi
}

PROMPT_COMMAND=prompt_command

# PS1='\[\033[32m\]\u\[\033[0m\]@\[\033[94m\]\h \[\033[95m\033[3m\]\W\[\033[0m\]$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

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
