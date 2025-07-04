set fish_greeting '( .-.)'

set PI 3.141592653589
set E 2.718281828459

fish_vi_key_bindings

set _TEMP /tmp/anton/

if not test -d $_TEMP
    mkdir -p $_TEMP
end

set -x GPG_TTY $(tty)

source ~/.config/fish/alias.fish
source ~/.config/fish/prompt.fish

plug --init --silent
