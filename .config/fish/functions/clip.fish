function clip
    set -g stdin
    if not tty -s >/dev/null
        read stdin
    end
    set stdin $(string trim -- $stdin)

    set -l argv $(string trim -- $argv)
    if test -n "$argv"
        echo "$argv" | xclip -selection clipboard
        return 0
    end

    if test -n "$stdin"
        echo "$stdin" | xclip -selection clipboard
        return 0
    end

    xclip -selection clipboard -o
end