# Starship prompt
if (( $+commands[starship] )); then
    eval "$(starship init zsh)"
fi

# Zoxide smart directory navigation
if (( $+commands[zoxide] )); then
    eval "$(zoxide init zsh --cmd cd)"
fi

# Git worktree management
if (( $+commands[wt] )); then
    eval "$(command wt config shell init zsh)"
fi

# Ruby version manager
if (( $+commands[rbenv] )); then
    eval "$(rbenv init - zsh)"
fi
