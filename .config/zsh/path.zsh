# Keep PATH entries unique
typeset -U path

# Homebrew
path=(
    /opt/homebrew/bin
    /opt/homebrew/sbin
    "$HOME/.config/scripts"
    $path
)

# User-installed tools
path+=(
    "$HOME/.dotnet/tools"
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
)

# JetBrains Toolbox
toolbox_path="$HOME/Library/Application Support/JetBrains/Toolbox/scripts"

if [[ -d "$toolbox_path" ]]; then
    path+=("$toolbox_path")
fi

unset toolbox_path
