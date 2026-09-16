export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git)
source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"

alias cd='z'
alias cl='clear'
alias dotnetx64="/usr/local/share/dotnet/x64/dotnet"
alias ff='fastfetch'
# alias ls='lsd --group-dirs first'
# alias ll='ls -Alh'
alias ls='colorls --sd'
alias ll='ls -Al --time-style="+%m-%d-%Y %H:%M:%S" --no-hardlinks'
alias mux="tmuxinator"
alias nv='nvim'
alias spotify="spotatui"
alias ss="~/bin/bash-screensavers/screensaver.sh"

# Neovim Configuration Aliases
alias brewvim="NVIM_APPNAME='brewvim'"
alias nvchad="NVIM_APPNAME='nvchad'"
alias ramboevim="NVIM_APPNAME='ramboevim'"
alias nv12="NVIM_APPNAME=''"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function sesh-sessions()
{
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -T -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    [[ -z "$session" ]] && return
    sesh connect $session
}

zle     -N             sesh-sessions
bindkey -M emacs '\eg' sesh-sessions
bindkey -M vicmd '\eg' sesh-sessions
bindkey -M viins '\eg' sesh-sessions

# Created by `pipx` on 2025-11-11 16:40:33
export PATH="$PATH:/Users/sbrewer/.local/bin"

eval "$(zoxide init zsh)"

if command -v wt >/dev/null 2>&1; then
    eval "$(command wt config shell init zsh)"
fi

if command -v rbenv 1>/dev/null 2>&1; then
    eval "$(rbenv init -)"
fi

source /opt/homebrew/opt/git-extras/share/git-extras/git-extras-completion.zsh
