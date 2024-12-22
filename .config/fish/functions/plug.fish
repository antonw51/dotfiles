# Simple custom made manager, because clearly we can't have nice things.
# (fisher uses config folder, and plug.fish has went through a rework)

function plug
    set -lx plug_path "$__fish_user_data_dir/plug"

    set -lx plug_completions "$plug_path/completions"
    set -lx plug_functions "$plug_path/functions"
    set -lx plug_meta "$plug_path/meta"
    set -lx plug_confd "$plug_path/conf.d" # startup
    set -lx plug_temp "$plug_path/tmp"

    function _plug_ensure_dir
        if not test -e $argv
            mkdir -p $argv
        end
    end

    _plug_ensure_dir $plug_path

    _plug_ensure_dir $plug_completions
    _plug_ensure_dir $plug_functions
    _plug_ensure_dir $plug_meta
    _plug_ensure_dir $plug_confd

    argparse -n plug -x i,r,u,I,l,q -x l,s 'i/install=' 'r/remove=' 'q/query=' 'u/update=' l/list I/init s/silent -- $argv
    or return 1

    set -lx verbose true
    if set -q _flag_silent
        set verbose false
    end

    if $verbose
        echo $(string join '' -- (set_color --bold white) "Plug v0.0.1" (set_color normal))
    end

    if not set -q _plug_initalized
        set -g _plug_initalized

        set fish_complete_path $fish_complete_path[1] \
            $plug_completions \
            $fish_complete_path[2..]

        set fish_function_path $fish_function_path[1] \
            $plug_functions \
            $fish_function_path[2..]

        for script in $plug_confd/*
            source $script
        end
    end

    if set -q _flag_init
        return 0
    end

    if $verbose
        echo $(string join '' -- (set_color green) " Plug ready")
    end

    set -l cmd
    set -l target

    if set -q _flag_install
        set target $_flag_install
        set cmd install
    else if set -q _flag_remove
        set target $_flag_remove
        set cmd remove
    else if set -q _flag_update
        set target $_flag_update
        set cmd update
    else if set -q _flag_query
        set target $_flag_query
        set cmd query
    end

    if set -q _flag_list
        set cmd list
    end

    if test -z $cmd
        if $verbose
            echo $(string join '' -- (set_color --bold red) " No command provided")
        end
        return 1
    end

    function _plug_parse_url
        set -l url $argv

        # long url
        if string match -q -r 'http(s)?:\/\/.*\..*\/.*\/.*' -- $url
            echo $url
            return 0
        end

        # short url
        if string match -q -r '.*\/.*' -- $url
            if $verbose
                echo $(string join '' -- (set_color yellow) " Using GitHub as git provider") 1>&2
            end
            set url "https://github.com/$url"
            echo $url

            return 0
        end

        if $verbose
            echo $(string join '' -- (set_color --bold red) " Not yet implemented")
        end
        return 1
    end

    function _plug_get_pack_name
        set -l url $argv

        set -l matches $(string match -r '(^.*\/|^)(.+?\/.*?)(.git)?$' -- $url)

        echo $matches[3]

        return 0
    end

    function _plug_install
        if $verbose
            echo $(string join '' -- (set_color yellow) " Installing $display")
        end


        set -l url $(_plug_parse_url $argv)

        if test -e $out
            if $verbose
                echo $(string join '' -- (set_color red) " Temporary directory for $name already exists ($out)")
                echo $(string join '' -- (set_color --bold red) " Failed to prepare installation, is there another plug process open?")
            end
            return 1
        end
        mkdir -p $out

        if test -e $journal
            if $verbose
                echo $(string join '' -- (set_color red) " Journal file $journal already exists")
                echo $(string join '' -- (set_color --bold red) " $name seems to already be installed, '--remove' it first, or use '--update' to reinstall it")
            end
            return 1
        end
        touch $journal

        if not set -l hash $(git ls-remote $url HEAD)
            echo $(string join '' -- (set_color --bold red) " Could not retrieve latest hash from $url, did you make a typo?")
            return 0
        end

        echo $(string match -r '(.*?)\s.*' -- $hash) >$journal

        set_color normal
        if not git clone $url $out
            if $verbose
                echo $(string join '' -- (set_color --bold red) " Failed to clone into $url")
            end
            return 1
        end
        echo $(string join '' -- (set_color green) " Cloned $url")

        set -l deps "$out/deps.plug"

        if test -e $deps
            echo $(string join '' -- (set_color --bold red) " Dependency resolution is not yet implemented")
            return 1
        else
            echo $(string join '' -- (set_color green) " No dependencies found")
        end

        function _plug_clone
            set -l from $argv[1]
            set -l to $argv[2]
            set -l label $argv[3]

            if not test -e $from
                if $verbose
                    echo $(string join '' -- (set_color yellow) " No $label scripts found") 1>&2
                end
                echo 0
                return 0
            end

            set -l counter 0

            for script in $from/*.fish
                set counter $(math $counter + 1)
                set -l basename $(basename $script)
                if not cp $script $to
                    if $verbose
                        echo $(string join '' -- (set_color --bold red) " Failed to copy $script")
                    end
                    return 1
                end
                echo "$to/$basename" >>$journal
            end

            if $verbose
                echo $(string join '' -- (set_color green) " Copied $counter $label script(s)") 1>&2
            end

            echo $counter
            return 0
        end

        set -l functions $(_plug_clone "$out/functions" "$plug_functions" "function"; or return 1)
        set -l completions $(_plug_clone "$out/completions" "$plug_completions" "completion"; or return 1)
        set -l confd $(_plug_clone "$out/conf.d" "$plug_confd" "conf.d"; or return 1)

        if not set -q _plug_trust_all
            echo $(string join '' -- (set_color yellow) " Prompting for permission")

            echo ""
            set_color --bold red
            echo "-- Disclaimer --"
            set_color normal
            echo "Plugins are external scripts at the end of the day. It's a good"
            echo "practice to always ensure that you get your plugins from reputable"
            echo "sources; remember that not all scripts are always safe."
            echo ""
            echo "If you're confident you've understood the security"
            echo "implications of external plugins you can disable this prompt"
            echo "and trust all future plugins, knowing that this serves as a"
            echo "warning against malicious code. \"conf.d\" scripts run every"
            echo "time your shell starts"
            echo ""

            set_color --bold white
            echo "Setup and allow $display to run?"
            set_color normal
            echo "(Y)es, [N]o, (T)rust all; don't ask again."

            if not read -l -P "> " answer
                echo $(string join '' -- (set_color yellow) " Cleaning up")

                for file in $(cat $journal)[2..]
                    rm $file
                end

                return 1
            end

            switch $answer
                case t T trust Trust TRUST
                    set -U _plug_trust_all true
                case y Y yes Yes YES
                case '*'
                    echo $(string join '' -- (set_color red) " Did not acquire permission")
                    echo $(string join '' -- (set_color yellow) " Cleaning up")

                    for file in $(cat $journal)[2..]
                        rm $file
                    end

                    echo $(string join '' -- (set_color --bold red) " Installation canceled")
                    return 1
            end
        end

        if test $confd -ne 0
            set -l scripts $(cat $journal)[2..]

            set scripts $(string match -r '.*/conf.d/.*\.fish$' -- $scripts)

            for script in $scripts
                source $script
            end

            echo $(string join '' -- (set_color green) " Ran conf.d scripts")
        end

        rm -rf $out
        echo $(string join '' -- (set_color green) " Successfully installed $display")
    end

    function _plug_is_up_to_date # Takes in a journal file as argument
        set -l hash $(cat "$plug_meta/$argv")[1]
        set -l name $(string replace '.' '/' -- $(basename $argv))

        set -l latest
        if not set latest $(git ls-remote $(_plug_parse_url $name))
            return false
        end

        if test $hash = $latest
            return true
        else
            return false
        end
    end


    switch $cmd
        case install
            set -lx display $(_plug_get_pack_name $target)
            set -lx name $(string replace -a '/' '.' -- $display)
            set -lx out "$plug_temp/$name"
            set -lx journal "$plug_meta/$name"

            if not _plug_install $target
                rm -rf $out >/dev/null 2>/dev/null
                rm $journal >/dev/null 2>/dev/null
                return 1
            end

            return 0
        case list
            set -l files $(ls "$plug_meta")
            echo $(string join '' -- (set_color green) " Found " (count $files) " journal(s)")

            for meta in $files
                set -l hash $(cat "$plug_meta/$meta")[1]
                echo $(string join '' -- \
                    (set_color normal) "  - " \
                    (set_color --bold white) (string replace '.' '/' -- $(basename $meta)) (set_color normal) \
                    (set_color --dim white) " (" \
                    (string shorten -c '' -m 6 -- $hash) ")")
            end
        case '*'
            if not set -q _flag_silent
                echo $(string join '' -- (set_color --bold red) " Not yet implemented")
            end
            return 1
    end

    return 2
end
