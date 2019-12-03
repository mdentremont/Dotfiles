if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

if test (uname) != Darwin
    abbr ls ls --color
end

# Use apt-fast if it exists
if type -q apt-fast
    alias apt-get="apt-fast"
end

if type -q ember
    abbr e ember
end

if type -q docker
    abbr docker-volume-cleanup docker volume rm (docker volume ls -qf dangling=true)
    abbr d docker
    abbr dc docker-compose
    abbr dm docker-machine
end

if type -q fuck
    thefuck --alias | source
end

# Fix ag colours
alias ag='ag --color-line="0;33" --color-path="0;32"'


# Alias gv to gvim if it exists
if type -q gvim
    function gv
        gvim -f "$argv" >/dev/null 2>&1 &
    end
    compdef gv=gvim
end

# Only set git aliases if git exists
if type -q git
    if type -q git.exe
        alias git git.exe
    end

    abbr g git

    abbr a git add
    abbr b git branch
    abbr co git checkout
    abbr d git diff
    abbr dc git diff --cached
    abbr gg cmd.exe /c start \"\" \"C:\\Program Files\\Git\\cmd\\git-gui.exe\"
    abbr f git fetch --prune
    abbr fa git fetch --all --prune
    abbr l git l
    abbr lp git lp
    abbr mt git mergetool
    abbr m git merge
    abbr r git reset
    abbr s git status -sb
    abbr stash git desk

    abbr wip git wip
    abbr unwip git unwip

    function git_cleanup_branches
        git fetch; and git_merged_branches | cut -d/ -f2- | xargs -r -n 1 git branch -D
    end

    function git_cleanup_remote_branches
        git fetch; and git_merged_branches -r | sed -e 's|^origin/||' | xargs --no-run-if-empty --max-args=1 git push origin --delete
    end 

    function get_remote_target_branches
        git for-each-ref --format='%(refname)' refs/remotes/origin/bugfix refs/remotes/origin/utilities refs/remotes/origin/rc refs/remotes/origin/feature/ refs/remotes/origin/hotfix/ refs/remotes/origin/rc/ refs/remotes/origin/bugfixdrop 2>/dev/null | sed 's|^refs/remotes/origin/||'
    end

    function git_merged_branches --argument-names 'remoteSwitch'
        if test "$remoteSwitch" = "-r"
            set refs "refs/remotes/"
        else
            set refs "refs/heads"
        end
        get_remote_target_branches | while read target_branch
            git for-each-ref --format='%(refname:short)' "--merged=origin/$target_branch" $refs 2>/dev/null
        end | sort -u | grep -vE '(^|/)(rc/.*|bugfix|bugfixdrop|feature/.*|production|master|rc|translations|utilities)$'
    end

    function git_cleanup_old_branches
        git fetch
        for branch in (git branch -r --no-merged origin/production | cut -d/ -f2- | grep -v -e '^production' -e '^bugfix' -e '^itk-release' -e '^utilities' -e '^feature' -e '^hotfix_' -e '^qa-drop')
            if [ -z "(git log -1 --since='6 month ago' -s origin/$branch)" ]
                git push --delete origin $branch
            end
        end 
    end 
end

abbr src cd /mnt/c/Users/matt.dentremont/git/intellitrack-service
abbr rel cd /mnt/c/Users/matt.dentremont/git/intellitrack-service-release
abbr vi nvim
abbr vim nvim

fish_vi_key_bindings


# oh-my-fish/theme-bobthefish
set -g theme_display_git_dirty no
set -g theme_display_git_untracked no

