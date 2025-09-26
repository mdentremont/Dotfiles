function __fish_dev_trees
    ls -1 ~/world/trees/ 2>/dev/null
end

# Complete tree names for dev cd -t
complete -c dev -n '__fish_seen_subcommand_from cd' -s t -xa '(__fish_dev_trees)'

