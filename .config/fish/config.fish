set fish_greeting '( .-.)'

set PI 3.141592653589
set E 2.718281828459

set _TEMP /tmp/anton/

if not test -d $_TEMP
    mkdir -p $_TEMP
end

source ~/.config/fish/alias.fish
source ~/.config/fish/prompt.fish

plug --init --silent
