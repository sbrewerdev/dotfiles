# Optional sesh integration
if (( $+commands[sesh] && $+commands[fzf] )); then
    function sesh-sessions() {
        local session

        session=$(sesh list -t -T -c |
            fzf --height 40% \
                --reverse \
                --border-label ' sesh ' \
                --border \
                --prompt '⚡  ')

        [[ -z "$session" ]] && return

        sesh connect "$session"
    }

    zle -N sesh-sessions

    bindkey -M emacs '\eg' sesh-sessions
    bindkey -M vicmd '\eg' sesh-sessions
    bindkey -M viins '\eg' sesh-sessions
fi
