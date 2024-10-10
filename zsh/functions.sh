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

APPLETS=("svelte" "react" "vite")

declare -A KNOWN_APPLETS=(
	["svelte"]="npm create svelte@latest"
	["react"]="npx create-next-app@latest"
	["vite"]="npm create vite@latest"
)

create() {
	if [[ -n "$KNOWN_APPLETS[$1]" ]]; then
		eval "$KNOWN_APPLETS[$1]"
	else
		echo "$fg[red]FATAL:$fg[white] I don't know that applet"
		echo "USAGE: create <applet>"
		echo "APPLETS:"
		echo "    $APPLETS"
		return 64
	fi
}
