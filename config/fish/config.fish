# Fish shell configuration file
# This file is loaded on startup of every interactive fish shell
# You can put any fish commands you want to run on startup here
# For more information, see `man fish` and `man fish_config`
# or visit https://fishshell.com/docs/current/index.html
# This needs packages: starship, eza, ripgrep, quickshell(optional)

function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive # Commands to run in interactive sessions can go here

    # No greeting
    set fish_greeting

    # Use starship
    starship init fish | source
    # Load quickshell terminal sequences if they exist
    # if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    #     cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    # end

    # Aliases
    alias pamcan pacman
    alias update 'sudo pacman -Syu'
    alias upgrade 'sudo pacman -Syuu'
    alias yay 'yay --noconfirm'
    alias please 'sudo'
    alias ls 'eza --icons --group-directories-first --color=auto'
    alias lsa 'eza --icons -a --group-directories-first --color=auto'
    alias ll 'eza --icons -l --group-directories-first --color=auto'
    alias lla 'eza --icons -la --group-directories-first --color=auto'
    alias la 'eza --icons -a --color=auto'
    alias vi 'nvim'
    alias svi 'sudo nvim'
    alias grep 'rg'
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias q 'qs -c ii'

end
