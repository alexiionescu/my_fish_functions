function logfiles --description "Generate prefixed date-based filenames (no .log on today)"
    set -l prefix $argv[1]
    set -l days $argv[2]
    set -l daysf $argv[3]

    if test -z "$days"
        set days 3
    end
    if test -z "$daysf"
        set daysf 0
    end

    for i in (seq $days -1 $daysf)
        if test "$i" -eq 0
            date -v -0d +"$prefix%Y-%m-%d"
        else
            if test "$i" -eq 1
                date -v -1d +"$prefix%Y-%m-%d"
            end
            date -v -"$i"d +"$prefix%Y-%m-%d.log"
        end
    end
end