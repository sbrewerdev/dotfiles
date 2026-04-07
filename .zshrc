eval "$(starship init zsh)"

alias cd='z'
alias cl='clear'
alias dotnetx64="/usr/local/share/dotnet/x64/dotnet"
alias ff='fastfetch'
alias ls='lsd --group-dirs first'
alias ll='ls -Alh'
alias mux="tmuxinator"
alias nv='nvim'
alias spotify="spotatui"
alias ss="~/bin/bash-screensavers/screensaver.sh"

# Neovim Configuration Aliases
alias brewvim="NVIM_APPNAME='brewvim'"
alias nvchad="NVIM_APPNAME='nvchad'"
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
