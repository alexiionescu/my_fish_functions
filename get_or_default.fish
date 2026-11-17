function get_or_default
    set -l var_name $argv[1]
    set -l default_name (string join "" $var_name "_DEFAULT")

    if set -q $var_name
        echo $$var_name
    else if set -q $default_name
        echo $$default_name
    else
        echo "Error: Default value not found. Please use set -U $default_name \"DEFAULT_VALUE\" to set it." >&2
        return 1
    end
end
