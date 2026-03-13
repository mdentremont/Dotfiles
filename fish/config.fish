if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

if not status --is-interactive
    return
end

if test -d ~/.local/state/tec/profiles/base/current/global
    # tec imports at the bottom of the file will take care of the aliasing
    # todo: might be nice to have wcd be running eza under the hood so that arguments are consistent

    abbr dcd dev cd
    set -x GH_TOKEN (/opt/dev/bin/dev github print-auth --password)

    abbr jicw wji checkout-web
    abbr jis wji shopify
    abbr jipw wji portable-wallets
    abbr jisfr wji storefront
else if type -q eza
    abbr ls eza
else if test (uname) != Darwin
    abbr ls ls --color
end

if type -q bat
    abbr cat bat
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
    abbr gd git diff
    abbr gs git status
    abbr gl git log
end

if type -q nvim
    abbr v nvim
    abbr vi nvim
    abbr vim nvim

    # This is the rare case where if some reason the abbr doesn't expand, I don't want it to run the real command
    alias vi nvim
    alias vim nvim
end

if type -q claude
    abbr claude "claude --dangerously-skip-permissions"
end

set fish_greeting

# Catppuccin Mocha theme colors (migrated from Fish 4.3 universal variables)
set -g fish_color_autosuggestion 6c7086
set -g fish_color_cancel f38ba8
set -g fish_color_command 89b4fa
set -g fish_color_comment 7f849c
set -g fish_color_cwd f9e2af
set -g fish_color_cwd_root red
set -g fish_color_end fab387
set -g fish_color_error f38ba8
set -g fish_color_escape eba0ac
set -g fish_color_gray 6c7086
set -g fish_color_history_current --bold
set -g fish_color_host 89b4fa
set -g fish_color_host_remote a6e3a1
set -g fish_color_keyword f38ba8
set -g fish_color_normal cdd6f4
set -g fish_color_operator f5c2e7
set -g fish_color_option a6e3a1
set -g fish_color_param f2cdcd
set -g fish_color_quote a6e3a1
set -g fish_color_redirection f5c2e7
set -g fish_color_search_match --background=313244
set -g fish_color_selection --background=313244
set -g fish_color_status f38ba8
set -g fish_color_user 94e2d5
set -g fish_color_valid_path --underline
set -g fish_pager_color_background
set -g fish_pager_color_completion cdd6f4
set -g fish_pager_color_description 6c7086
set -g fish_pager_color_prefix f5c2e7
set -g fish_pager_color_progress 6c7086
set -g fish_pager_color_secondary_background
set -g fish_pager_color_secondary_completion
set -g fish_pager_color_secondary_description
set -g fish_pager_color_secondary_prefix
set -g fish_pager_color_selected_background
set -g fish_pager_color_selected_completion
set -g fish_pager_color_selected_description
set -g fish_pager_color_selected_prefix

#fish_add_path -p \
#    /nix/var/nix/profiles/default/bin \
#    ~/.nix-profile/bin \
#    ~/.dev/userprofile/bin \
#    ~/.dev/binaries \
#    ~/bin \
#    ~/.local/bin \
#    /usr/local/bin \
#    /opt/homebrew/bin/

function fish_user_key_bindings
    fish_vi_key_bindings
end

# case insensitive less search
set -x LESS '-I -R'

# Added by tec agent
test -x /Users/mattdentremont/.local/state/tec/profiles/base/current/global/init && /Users/mattdentremont/.local/state/tec/profiles/base/current/global/init fish | source
