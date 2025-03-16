if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

if test -f /opt/dev/dev.fish
    source /opt/dev/dev.fish
end

if type -q bat
    abbr cat bat
end

if type -q dev
    abbr dcd dev cd
end

if type -q eza
    abbr ls eza
else if test (uname) != Darwin
    abbr ls ls --color
end

if type -q fuck
    set -x THEFUCK_OVERRIDDEN_ALIASES 'apt-get,ag,git'
    function update_the_fuck
        thefuck --alias >~/.config/fish/functions/fuck.fish
        source ~/.config/fish/functions/fuck.fish
    end
end

if type -q git
    abbr g git
    abbr gs git status
    abbr gl git log

    function git_cleanup_branches
        git fetch; and git_merged_branches | cut -d/ -f2- | xargs --no-run-if-empty --max-args=1 git branch -D
    end

    function git_cleanup_remote_branches
        git fetch; and git_merged_branches -r | sed -e 's|^origin/||' -e "s|'|\\\\'|" | xargs --no-run-if-empty --max-args=1 git push --delete origin
    end

    function get_remote_target_branches
        git for-each-ref --format='%(refname)' refs/remotes/origin/bugfix refs/remotes/origin/utilities refs/remotes/origin/rc refs/remotes/origin/feature/ refs/remotes/origin/hotfix/ refs/remotes/origin/rc/ refs/remotes/origin/bugfixdrop refs/remotes/origin/misc/high refs/remotes/origin/misc/low refs/remotes/origin/misc/drop refs/remotes/origin/misc/test 2>/dev/null | sed 's|^refs/remotes/origin/||'
    end

    function git_merged_branches --argument-names remoteSwitch
        if test "$remoteSwitch" = -r
            set refs refs/remotes/
        else
            set refs refs/heads
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

if type -q nvim
    abbr v nvim
    abbr vi nvim
    abbr vim nvim
end

if type -q spin
    abbr s s
    abbr sl spin list
    abbr sc spin code
    abbr scl spin code -l
    abbr scs spin code -l shop--world//areas/core/shopify
    abbr scw spin code -l shop--world//areas/clients/checkout-web
    abbr scpw spin code -l shopify--portable-wallets
    abbr so spin open
    abbr sol spin open -l
    abbr ss spin shell
    abbr ssl spin shell -l
end

set fish_greeting

set -U fish_user_paths ~/bin ~/.local/bin /usr/local/bin /opt/homebrew/bin/ $fish_user_paths

fish_vi_key_bindings

# case insensitive less search
set -x LESS '-I -R'
