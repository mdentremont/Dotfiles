if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

if test (uname) != Darwin
    abbr ls ls --color
end

if type -q ember
    abbr e ember
end

#if type -q docker
#    abbr docker-volume-cleanup docker volume rm (docker volume ls -qf dangling=true)
#    abbr d docker
#    abbr dc docker-compose
#    abbr dm docker-machine
#
#    if uname -a | grep -q 'Microsoft'
#        # wsl docker
#        set -x DOCKER_HOST tcp://localhost:2375
#    end
#end

if type -q fuck
    set -x THEFUCK_OVERRIDDEN_ALIASES 'apt-get,ag,git'
    function update_the_fuck
        thefuck --alias > ~/.config/fish/functions/fuck.fish
        source ~/.config/fish/functions/fuck.fish
    end
end

# Use ripgrep instead of silver searcher
abbr ag rg

# Alias gv to gvim if it exists
if type -q gvim
    function gv
        gvim -f "$argv" >/dev/null 2>&1 &
    end
    compdef gv=gvim
end

# Only set git aliases if git exists
if type -q git
    abbr g git

    abbr a git add
    abbr b git branch
    abbr co git checkout
    abbr d git diff
    abbr dc git diff --cached
    abbr gg cmd.exe /c start \"\" \"C:\\Program Files\\Git\\cmd\\git-gui.exe\"
    abbr gs git status
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
        git fetch; and git_merged_branches | cut -d/ -f2- | xargs --no-run-if-empty --max-args=1 git branch -D
    end

    function git_cleanup_remote_branches
        git fetch; and git_merged_branches -r | sed -e 's|^origin/||' -e "s|'|\\\\'|" | xargs --no-run-if-empty --max-args=1 git push --delete origin
    end

    function get_remote_target_branches
        git for-each-ref --format='%(refname)' refs/remotes/origin/bugfix refs/remotes/origin/utilities refs/remotes/origin/rc refs/remotes/origin/feature/ refs/remotes/origin/hotfix/ refs/remotes/origin/rc/ refs/remotes/origin/bugfixdrop refs/remotes/origin/misc/high refs/remotes/origin/misc/low refs/remotes/origin/misc/drop refs/remotes/origin/misc/test 2>/dev/null | sed 's|^refs/remotes/origin/||'
    end

    function git_copy_head
        git rev-parse HEAD | clip.exe
    end

    function git_merged_branches --argument-names 'remoteSwitch'
        if test "$remoteSwitch" = "-r"
            set refs "refs/remotes/"
        else
            set refs "refs/heads"
        end
        get_remote_target_branches | while read target_branch
            git for-each-ref --format='%(refname:short)' "--merged=origin/$target_branch" $refs 2>/dev/null
        end | sort -u | grep -vE '(^|/)(rc/.*|bugfix|bugfixdrop|feature/.*|misc/.*|production|master|rc|rc-next|translations|utilities|hotfix|HEAD)$'
    end

    function git_cleanup_old_branches
        git fetch
        for branch in (git branch -r --no-merged origin/production | cut -d/ -f2- | grep -v -e '^production' -e '^bugfix' -e '^itk-release' -e '^utilities' -e '^feature/' -e '^hotfix/' -e '^qa-drop' -e '^misc/*' )
            if [ -z "(git log -1 --since='6 month ago' -s origin/$branch)" ]
                git push --delete origin $branch
            end
        end
    end
end

if uname -a | grep -q 'Microsoft'
    set -x BROWSER "win-start"
    set fish_term24bit 1

    set -g WIN_HOME /mnt/c/Users/matt.dentremont
    set -g DESKTOP $WIN_HOME/Desktop

    abbr src cd $WIN_HOME/git/intellitrack-service
    abbr rel cd $WIN_HOME/git/intellitrack-service-release
    abbr other cd $WIN_HOME/git/intellitrack-service-other
    abbr core cd $WIN_HOME/git/intellitrack-service-core
    abbr desk cd $DESKTOP

    alias gh=gh.exe
end

abbr bat batcat
abbr v nvim
abbr vi nvim
abbr vim nvim

set -U fish_user_paths ~/bin ~/.local/bin $fish_user_paths

fish_vi_key_bindings

# oh-my-fish/theme-bobthefish
set -g theme_display_git_dirty no
set -g theme_display_git_untracked no

# case insensitive less search
set -x LESS '-I -R'
