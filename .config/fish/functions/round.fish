function round
    argparse -n "round" -i "p/precision=!_validate_int" -- $argv
    or return 1

    set -l value $argv

    set -l precision 0
    if set -q _flag_precision
        set precision $_flag_precision
    end

    set precision $(math 10 ^ $precision)

    set value $(math $value x $precision)

    set -l right $(math $value % 1)

    set value $(math $value - $right)
    set value $(math $value / $precision)

    echo $value
end