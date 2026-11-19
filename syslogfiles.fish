function syslogfiles --description "Generate syslog filenames based on server id"
    set -l server $argv[1]
    set -l days $argv[2]
    set -l filter_expr $argv[3]

    set -l guid (awk -F'\t' '$1 ~ /'$server'/ { print $5 }' $HOME/Desktop/logs/Dcc-Servers.tsv)
    set -l syslog_server PoltysSysLog

    if test -z "$days"
        set days 3
    end

    # get computer name folder
    set -l today (date +%Y_%m_%d)
    set -l remote_path (ssh $syslog_server "ls /var/log/hosts/DCC-$guid/*/"$today"_syslog.log" 2>/dev/null)
    if test -n "$remote_path"
        # Strips the filename (.../LANARK-WINDOWS), then grabs the folder name (LANARK-WINDOWS)
        set -l computer_name (path basename (path dirname $remote_path))
        for i in (seq $days -1 0)
            set -l filename (date -v -"$i"d +"/var/log/hosts/DCC-$guid/$computer_name/%Y_%m_%d_syslog.log")
            ssh $syslog_server "rg -NI -e '"$filter_expr"' $filename | logtr1" 2>/dev/null
        end
    end

end