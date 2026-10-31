# Zsh login shell configuration
export ZSH_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

source "$ZSH_CONFIG_DIR/path.zsh"
source "$ZSH_CONFIG_DIR/env.zsh"

# Machine-specific login configuration
if [[ -f "$ZSH_CONFIG_DIR/local/profile.zsh" ]]; then
    source "$ZSH_CONFIG_DIR/local/profile.zsh"
fi
