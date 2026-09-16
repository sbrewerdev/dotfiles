#!/usr/bin/env zsh

# kitty-font-by-monitor.zsh
# Requires: aerospace, jq, kitty

# Map monitor name → font size (similar to your wezterm pick_font_for_screen)
font_for_monitor() {
    local name=$(echo "$1" | tr '[:upper:]' '[:lower:]')

    if [[ "$name" == *"built"* ]]; then
        echo 25
        return
    fi
    if [[ "$name" == *"ultragear"* ]]; then
        echo 26
        return
    fi
    if [[ "$name" == *"vg27aq1a"* ]]; then
        echo 14
        return
    fi
    if [[ "$name" == *"sidecar"* ]]; then
        echo 11.7
        return
    fi
    if [[ "$name" == *"u32j59"* ]]; then
        echo 32
        return
    fi
    if [[ "$name" == *"k243y e"* ]]; then
        echo 11
        return
    fi

    # fallback
    echo 16
}

# Get the currently focused window from Aerospace
focused_json=$(aerospace list-windows --focused --format '%{app-name} %{monitor-name}' --json 2>/dev/null) || exit 0

# If nothing is focused, bail
if [[ "$focused_json" == "[]" || -z "$focused_json" ]]; then
    exit 0
fi

app_name=$(echo "$focused_json"     | jq -r '.[0]."app-name"')
monitor_name=$(echo "$focused_json" | jq -r '.[0]."monitor-name"')

# Only adjust when the focused app is kitty
if [[ "$app_name" != "kitty" ]]; then
    exit 0
fi

size=$(font_for_monitor "$monitor_name")

if [[ -z "$KITTY_LISTEN_ON" ]]; then
    # No socket known - nothing to talk to
    exit 0
fi

# Apply font size for the current kitty instance
# If you use listen_on, you can target it explicitly, e.g.:
# kitty @ --to unix:/tmp/kitty set-font-size "$size"
kitty @ --to "$KITTY_LISTEN_ON" set-font-size "$size"
