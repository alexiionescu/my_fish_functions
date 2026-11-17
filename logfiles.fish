function logfiles --description "Generate prefixed date-based filenames (no .log on today)"
    set -l prefix $argv[1]
    set -l days $argv[2]

    if test -z "$days"
        set days 3
    end

    for i in (seq $days -1 0)
        if test "$i" -eq 0
            date -v -0d +"$prefix%Y-%m-%d"
        else
            date -v -"$i"d +"$prefix%Y-%m-%d.log"
        end
    end
end