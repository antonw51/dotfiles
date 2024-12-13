function layout
    argparse -n "layout" "v/verbose" "t/target=" -- $argv
    or return 1

    set _target

    if set -q _flag_target
        set _target "$_flag_target"
    end

    if test -f "$_TEMP/curr-layout"
        if not set -q _flag_target
            switch (cat "$_TEMP/curr-layout")
            case us
                set _target "sv"
            case se
                set _target "us"
            case sv
                set _target "us"
            case '*'
                if set -q _flag_verbose
                    echo "Unregognized layout set in /curr-layout file; stopping..."
                end
                return 1
            end
        end
    else
        if set -q _flag_verbose; and not set -q _flag_target
            echo "Could not determine current layout; defaulting to US"
        end
        echo "us" > "$_TEMP/curr-layout"
        if not set -q _flag_target
            set _target "sv"
        end
    end

    if not set -q _target
        return 2
    end

    if set -q _flag_verbose
        switch (echo $_target)
        case sv
            echo "Switching to Swedish layout..."
        case us
            echo "Switching to U.S. layout..."
        end
    end

    switch (echo $_target)
    case sv
        set _target se
    case '*'
    end

    if setxkbmap -layout $_target
        echo $_target > "$_TEMP/curr-layout"
    end

    return $status
end