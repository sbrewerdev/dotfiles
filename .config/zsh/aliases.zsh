# General utilities
alias cl='clear'
alias ff='fastfetch'
alias mux='tmuxinator'
alias nv='nvim'
alias spotify='spotatui'

# File listings
if (( $+commands[colorls] )); then
    alias ls='colorls --sd'
    alias ll='colorls --sd -Al --time-style="+%m-%d-%Y %H:%M:%S" --no-hardlinks'
else
    alias ll='ls -Al'
fi

# .NET
if [[ -x /usr/local/share/dotnet/x64/dotnet ]]; then
    alias dotnetx64='/usr/local/share/dotnet/x64/dotnet'
fi

# Screensaver
alias ss='"$HOME/bin/bash-screensavers/screensaver.sh"'

# Neovim configurations
alias brewvim='NVIM_APPNAME=brewvim nvim'
alias nvchad='NVIM_APPNAME=nvchad nvim'
alias ramboevim='NVIM_APPNAME=ramboevim nvim'
alias nv12='NVIM_APPNAME=nvim nvim'
