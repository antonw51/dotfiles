# Custom prompt
update_prompt() {
	ret_code=$?
	PROMPT=""

	# Git
	if [[ $(git_repo_name) ]]; then
		# PROMPT+="%{$fg[yellow]%}$(git remote show | head -n 1)"
		# PROMPT+="%{$fg_bold[magenta] $(git_repo_name)"
		# PROMPT+="%{$fg_bold[blue]($(git_current_branch))%{$fg[white]%}:"
		if [[ -n "$(git remote show)" ]]; then
			PROMPT+="%{$fg[yellow]%}$(git remote show | head -n 1)"
		else
			PROMPT+="%{$fg_bold[red]%}NO-REMOTE"
		fi
		PROMPT+=" %{$fg_bold[magenta]%}$(git_repo_name)%{$fg_bold[blue]%}($(git_current_branch))%{$fg[white]%}:"

	fi

	# Path
	PROMPT+="%{$fg[cyan]%}%c%{$reset_color%} "

	# Arrow
	if [[ started -eq 0 ]] || [[ $ret_code -eq 0 ]]; then
		PROMPT+="%{$fg_bold[green]%}%1{➜%} "
	else
		PROMPT+="%{$fg[red]%}%? %{$fg_bold[red]%}%1{➜%} "
	fi
	# PROMPT+="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg[red]%}(%?%) %{$fg_bold[red]%}%1{➜%} )"
	# PROMPT+="%(?:%{${started:+$fg_bold[green]}${started:=$fg[green]}%}%1{➜%} :%{${started:+$fg_bold[green]%)"
	
	return $?
}

update_prompt

# Define a map of error codes to messages
declare -A ERROR_MESSAGES=(
	[64]="USAGE"
	[65]="FORMAT"
	[68]="HOSTNAME"
	[69]="UNAVAIL"
	[70]="SOFTWARE"
	[71]="OSERR"
	[72]="OSFILE"
	[73]="CREATEFAIL"
	[74]="IOERR"
	[75]="TEMP"
	[76]="PROTOCOL"
	[77]="DENIED"
    [78]="CONFERR"   # Configuration error
	[126]="EXECFAIL"
    [127]="COMMAND"   # Command not found
	[130]="SIGINT"
	[137]="SIGKILL"
    # Add more error codes and messages as needed
)

# === FUNCTIONS FOR COMMAND TIMING ===

# Function to capture the start time of the command in milliseconds
preexec() {
	started=1
    timer_start=$(( $(date +%s%3N) ))  # Captures current time in milliseconds
}

# Function to capture the end time of the command and calculate the elapsed time
precmd() {
	update_prompt
	if [[ started -eq 0 ]]; then
		RPROMPT=""
		return
	fi
	started=0

    local timer_end=$(( $(date +%s%3N) ))  # Captures current time in milliseconds
    local elapsed=$((timer_end - timer_start))

    # Reset RPROMPT
    RPROMPT=""

    # Handle error codes: Prepend the error message if the command failed
	if [[ ret_code -ne 0 ]]; then
        local error_msg=${ERROR_MESSAGES[$ret_code]}
        if [[ -n $error_msg ]]; then
            RPROMPT="%{$fg_bold[red]%}(${error_msg})%{$reset_color%}$RPROMPT"
        fi
    fi

    # Do not display the time if it is above 100 hours (360000000 ms)
    if (( elapsed > 360000000 )); then
        return
    fi

    if (( elapsed > 0 )); then
        local color time_str
        local seconds=$((elapsed / 1000))
        local milliseconds=$((elapsed % 1000))

        if (( seconds >= 60 )); then
            local minutes=$((seconds / 60))
            seconds=$((seconds % 60))
            if (( minutes >= 60 )); then
                local hours=$((minutes / 60))
                minutes=$((minutes % 60))
                time_str="${hours}h ${minutes}m"
                if (( seconds > 0 )); then
                    time_str="${time_str} ${seconds}s"
                fi
            else
                time_str="${minutes}m"
                if (( seconds > 0 )); then
                    time_str="${time_str} ${seconds}s"
                fi
            fi
            color="%{$fg[red]%}"
        elif (( seconds >= 10 )); then
            time_str="${seconds}s"
            color="%{$fg[orange]%}"
        elif (( seconds >= 5 )); then
            time_str="${seconds}s"
            color="%{$fg[yellow]%}"
        elif (( seconds >= 1 )); then
            time_str="${seconds}s ${milliseconds}ms"
            color="%{$fg_bold[green]%}"
        else
            time_str="${milliseconds}ms"
            color="%{$fg_bold[green]%}"
        fi

        # Append the time string to RPROMPT
        if [[ -n $time_str ]]; then
            RPROMPT="${RPROMPT} ${color}${time_str}%{$reset_color%}"
        fi
    fi
}
