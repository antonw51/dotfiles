set fish_greeting '( .-.)'

set PI 3.141592653589

set _TEMP '/tmp/anton/'

if not test -d $_TEMP
    mkdir -p $_TEMP
end

source ~/.config/fish/alias.fish

set -l last_status $status

function fish_mode_prompt; end

function fish_prompt
    set -l duration $CMD_DURATION

    if test $CMD_DURATION -gt 700
        set -l seconds $(round -p 2 $(math $duration / 1000 % 60))
        set seconds $seconds "s"
        set -l minutes 
        if test $duration -gt 60000
            set minutes $(round (math $duration / 60000))
            set minutes $minutes "m "
        end
        

        string join '' -- (set_color white) "took " (set_color yellow) $minutes $seconds
    end

    set -l mode
    switch (echo $fish_bind_mode)
    case default
      set mode $(string join '' -- (set_color --bold red) '[N] ' (set_color normal))
    case insert
      set mode $(string join '' -- (set_color --bold cyan) '[I] ' (set_color normal))
    case replace_one
      set mode $(string join '' -- (set_color --bold green) '[R] ' (set_color normal))
    case visual
      set mode $(string join '' -- (set_color --bold brmagenta) '[V] ' (set_color normal))
    case '*'
      set mode $(string join '' -- (set_color --bold red) '[?] ' (set_color normal))
    end

    set -l last_status $status

    set -l cursor_color $(set_color green)

    if test $last_status -ne 0
        set last_status $(string join '' -- (set_color red) " [$last_status]")
        set cursor_color $(set_color red)
    else
        set last_status ""
    end

    set -l git $(string trim -- (fish_vcs_prompt))
    if test -n "$git"
        set git $(string join '' -- (set_color yellow) " 󰘬 " (string sub -s 2 $git -e -1) " ") 
    end

    set -l pwd $(string join '' -- (set_color green) (prompt_pwd -D 2 -d 1) (set_color normal))

    string join '' -- $mode $pwd $last_status $git $cursor_color '|> '
end