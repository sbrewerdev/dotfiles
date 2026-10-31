# Git Extras completion
git_extras_completion="/opt/homebrew/opt/git-extras/share/git-extras/git-extras-completion.zsh"

if [[ -f "$git_extras_completion" ]]; then
    source "$git_extras_completion"
fi

unset git_extras_completion
