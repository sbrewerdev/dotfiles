# Zsh interactive shell configuration
export ZSH_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
    ZSH_THEME=""
    plugins=(git)
    source "$ZSH/oh-my-zsh.sh"
fi

# Shared configuration
source "$ZSH_CONFIG_DIR/tools.zsh"
source "$ZSH_CONFIG_DIR/aliases.zsh"
source "$ZSH_CONFIG_DIR/completions.zsh"

# Custom functions
for file in "$ZSH_CONFIG_DIR"/functions/*.zsh(N); do
    source "$file"
done

# Machine-specific interactive configuration
for file in "$ZSH_CONFIG_DIR"/local/*.zsh(N); do
    [[ "$file" == "$ZSH_CONFIG_DIR/local/profile.zsh" ]] && continue
    source "$file"
done
