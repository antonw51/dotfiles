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

# make and cd into directory
into() {
	mkdir -p "$1" && cd "$1";
}

# make a new terminal
split() {
	(kitty . &)
}

# === FUNCTIONS FOR COMMAND TIMING ===

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

	timer_start=0
}
