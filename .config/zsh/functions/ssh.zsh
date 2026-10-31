# FilePro servers require CP437 terminal encoding
function _filepro_ssh() {
    local hostname="$1"
    shift

    if ! (( $+commands[luit] )); then
        print -u2 "Error: luit is not installed."
        return 1
    fi

    luit -encoding CP437 ssh "${USER}@${hostname}" "$@"
}

# Web servers require a compatible TERM value
function _web_ssh() {
    local hostname="$1"
    shift

    TERM=linux command ssh "root@${hostname}" "$@"
}

# FilePro servers
function filepro() {
    _filepro_ssh "filepro.wisvis.com" "$@"
}

function fpdev() {
    _filepro_ssh "fpdev.wisvis.com" "$@"
}

function fpstage() {
    _filepro_ssh "fpstage.wisvis.com" "$@"
}

function fptest2() {
    _filepro_ssh "fptest2.wisvis.com" "$@"
}

# Web servers
function webprod() {
    _web_ssh "webprod.wisvis.com" "$@"
}

function webqa() {
    _web_ssh "webqa.wisvis.com" "$@"
}

function webqa2() {
    _web_ssh "webqa2.wisvis.com" "$@"
}

function websandbox() {
    _web_ssh "websandbox.wisvis.com" "$@"
}
