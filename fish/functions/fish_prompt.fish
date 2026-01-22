# Astronaut prompt
function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l last_duration $CMD_DURATION
    set -l normal (set_color normal)
    set -l status_color (set_color brgreen)
    set -l cwd_color (set_color $fish_color_cwd)
    set -l vcs_color (set_color brpurple)
    set -l duration_color (set_color bryellow)
    set -l prompt_status ""
    set -l prompt_duration ""

    # Show duration for commands that took longer than 1 second
    if test $last_duration -gt 1000
        set -l seconds (math --scale=1 $last_duration / 1000)
        if test $seconds -ge 60
            set -l minutes (math --scale=0 $seconds / 60)
            set -l remaining_seconds (math --scale=0 $seconds % 60)
            set prompt_duration $duration_color " " $minutes m $remaining_seconds s $normal
        else
            set prompt_duration $duration_color " " $seconds s $normal
        end
    end

    # Since we display the prompt on a new line allow the directory names to be longer.
    set -q fish_prompt_pwd_dir_length
    or set -lx fish_prompt_pwd_dir_length 0

    # Color the prompt differently when we're root
    set -l suffix '❯'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set cwd_color (set_color $fish_color_cwd_root)
        end
        set suffix '#'
    end

    # Color the prompt in red on error
    if test $last_status -ne 0
        set status_color (set_color $fish_color_error)
        set prompt_status $status_color "[" $last_status "]" $normal
    end

    echo -s (prompt_login) ' ' $cwd_color (prompt_pwd) $vcs_color (fish_vcs_prompt) $normal $prompt_duration ' ' $prompt_status
    echo -n -s $status_color $suffix ' ' $normal
end
