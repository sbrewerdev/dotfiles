#!/usr/bin/env zsh

# This scripts enables using Kitty as an external console for Rider when running dotnet code.
# By default, rider uses Terminal.app, which is just gross, so, here's my work-around to force
# using Kitty as the external console!

# Args passed in from JetBrains Rider:
#   $1 - working directory (project directory or solution directory)
#   $2 - command to run (e.g. "dotnet run")
#   $3 - any extra args after $2 is passed through

WORK_DIR="$1"
shift

if [ -z "$WORK_DIR" ]; then
    echo "No working directory provided."
    exit 1
fi

CMD="$*"

if [ -z "$CMD" ]; then
    echo "No command provided."
    exit 1
fi

# Path to Kitty
KITTY_BIN="$(which kitty)"

if [ ! -x "$KITTY_BIN" ]; then
    echo "Kitty not found at $KITTY_BIN"
    exit 1
fi

cd "$WORK_DIR" || exit 1

# Launch kitty, run the command in a login shell, then keep the window open briefly
# # Remove the 'read' bits if you want kitty to close when the command terminates.
"$KITTY_BIN" -e bash -lc "$CMD; echo; echo '--- process finished ---'; echo 'Press any key to close...'; read -n 1"
