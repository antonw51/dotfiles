function vpn
    argparse -n "vpn" -x e,d -x q,s 'e/enable' 'd/disable' 's/status' 'q/quiet' 'f/force' -- $argv 
    or return 1

    set _silent false
    if set -q _flag_quiet
        set _silent true
    end

    set _path ~/wg0.conf
    set _status false

    if test -f "$_TEMP/vpn-status"
        switch (cat "$_TEMP/vpn-status")
        case true
            set _status true
        case false
            set _status false
        case '*'
            if not $_quiet
                echo "Unregognized /vpn-status contents, exiting!"
            end
            return 1
        end
    else
        if not $_silent
            echo "Did not find status file; creating..."
            echo "false" >> "$_TEMP/vpn-status"
        end
    end 

    if set -q _flag_status
        if $_status
            echo "VPN is active."
        else
            echo "VPN is inactive."
        end
        return 0
    end

    if not set -q _flag_enable; and not set -q _flag_disable
        if $_status
            set _flag_disable
        else 
            set _flag_enable
        end
    end

    if set -q _flag_enable
        if $_status; and not set -q _flag_force
            if not $_silent
                echo "Already enabled."
            end
            return 0
        end

        if sudo wg-quick up $_path
            echo "true" > "$_TEMP/vpn-status"
            if not $_silent
                echo "Successfully enabled."
            end
        end
        return $status
    end

    if set -q _flag_disable
        if not $_status; and not set -q _flag_force
            if not $_silent
                echo "Already disabled."
            end
            return 0
        end

        if sudo wg-quick down $_path
            echo "false" > "$_TEMP/vpn-status"
            if not $_silent
                echo "Successfully disabled."
            end
        end
        return $status
    end

    return 2
end
