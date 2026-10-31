# Kitty Terminal Configuration

A highly customized Kitty terminal setup with tmux-like session management, dynamic font sizing based on connected displays, and optimized keybindings for efficient workflow.

## High-Level Flow

This configuration creates a **session-based terminal workflow** similar to tmux or screen:

1. **Startup**: Terminal launches with the `home` session (configurable in `sessions.conf`)
2. **Session Management**: Quick navigation between named sessions (projects, work contexts, etc.)
3. **Window Splitting**: Split panes within sessions using keyboard shortcuts
4. **Display Adaptation**: Font size automatically adjusts based on connected external display
5. **Remote Control**: Enables Kitty's remote control protocol for scripted terminal interactions

### Key Concepts

- **Sessions**: Named workspaces (home, dotfiles, notes, GitHub projects, filePro versions)
- **Layouts**: Grid and split-pane layouts for organizing terminal windows
- **Leader Key Bindings**: `Ctrl+S` prefix for session management (tmux-style)
- **PowerLine Tabs**: Visual tab bar with session name display

## Dependencies

### Required

- **Kitty Terminal**: v0.30.0+ (https://sw.kovidgoyal.net/kitty/)
- **Zsh**: Default shell (configure in `kitty.conf` if using bash/fish)
- **Python 3.8+**: For dynamic font sizing script

### Optional (for full functionality)

- **Yabai** (macOS): Required for `current-monitor-font-size.py` to detect external displays
  - Install: `brew install yabai`
  - Or manually adjust font size: `Cmd+Shift+=` / `Cmd+Shift+-`

- **Nerd Font**: For better icon/symbol rendering (if using one)

## Installation

1. Copy this directory to `~/.config/kitty/`
2. Ensure all included files are present:
   ```
   conf.d/           # Configuration modules
   sessions/         # Saved session definitions
   themes/           # Color themes
   *.py              # Helper scripts
   leader.sh         # Leader key bindings
   ```

3. Open Kitty or reload config: `Cmd+Shift+R`

## Keybinds Summary

### Core Navigation

| Keybind | Action |
|---------|--------|
| `Cmd+T` | New tab with current working directory |
| `Cmd+1` to `Cmd+9` | Jump to tab 1-9 |
| `Cmd+Shift+R` | Reload entire config |

### Window Management (require Ctrl+S prefix first)

| Keybind | Action |
|---------|--------|
| `Ctrl+S` → `\` | Split window vertically |
| `Ctrl+S` → `-` | Split window horizontally |
| `Ctrl+H` | Focus window to the left |
| `Ctrl+L` | Focus window to the right |
| `Ctrl+K` | Focus window above |
| `Ctrl+J` | Focus window below |
| `Ctrl+Shift+H` | Move window left |
| `Ctrl+Shift+L` | Move window right |
| `Ctrl+Shift+K` | Move window up |
| `Ctrl+Shift+J` | Move window down |

### Session Management (Ctrl+S prefix)

| Keybind | Action |
|---------|--------|
| `Ctrl+S` → `S` | Browse and select from saved sessions |
| `Ctrl+S` → `D` | Go to "dotfiles" session |
| `Ctrl+S` → `H` | Go to "home" session |
| `Ctrl+S` → `N` | Go to "notes" session |
| `Ctrl+S` → `G` → `P` | Go to GitHub personal session |
| `Ctrl+S` → `G` → `W` | Go to GitHub work session |
| `Ctrl+S` → `F` → `4` | Go to filePro v4 session |
| `Ctrl+S` → `F` → `6` | Go to filePro v6 session |
| `Ctrl+Shift+S` | Save current layout as new session |

### Font Sizing

| Keybind | Action |
|---------|--------|
| `Cmd+Shift+F` | Auto-detect monitor and set optimal font size |
| `Ctrl+Shift+=` | Increase font size by 2pt |
| `Ctrl+Shift+-` | Decrease font size by 2pt |

### Special Keys (filePro compatibility)

| Keybind | Action |
|---------|--------|
| `F1` through `F4` | Function key sequences |
| `Home` | Send Home key sequence |
| `End` | Send End key sequence |
| `Cmd+Alt+L` | Send special separator line |

## Configuration Organization

- **`kitty.conf`**: Main configuration and includes
- **`conf.d/`**: Modular config files
  - `appearance.conf`: Colors, opacity, styling
  - `cursor.conf`: Cursor appearance and behavior
  - `fonts.conf`: Font families and sizes
  - `keybinds.conf`: Keyboard shortcuts
  - `layouts.conf`: Pane layouts
  - `sessions.conf`: Session defaults
  - `tabs.conf`: Tab bar styling
  - `leader-keybinds.conf`: Leader key definitions
- **`leader.sh`**: Shell script implementing Ctrl+S bindings
- **`sessions/`**: Saved terminal session configurations
- **`themes/`**: Color theme definitions
- **`current-monitor-font-size.py`**: Script to detect display and set font size

## Customization

### Add a New Session

1. Create a session template in Kitty:
   ```bash
   # Organize windows and tabs as desired
   Ctrl+Shift+S  # Save current layout as session
   ```

2. Edit `leader.sh` to add quick access:
   ```bash
   "x")
     kitten @ action goto_session ~/.config/kitty/sessions/my-session.kitty-session
     ;;
   ```

### Change Theme

Edit `conf.d/appearance.conf` and uncomment a different theme from the `themes/` folder.

### Modify Display Font Sizes

To add your display's optimal font size:

1. **Get your display resolution**:
   ```bash
   /opt/homebrew/bin/yabai -m query --displays --display
   ```
   
   Output example:
   ```json
   {
     "id": 1,
     "uuid": "...",
     "frame": {
       "x": 0,
       "y": 0,
       "w": 3440,
       "h": 1440
     }
   }
   ```
   
   Note the width (`w`) and height (`h`) values—in this example: `(3440, 1440)`

2. **Choose an appropriate font size** for that resolution (usually 2-3pt per 100px of width)

3. **Update `current-monitor-font-size.py`**:
   Add your resolution tuple and font size to the `DISPLAY_FONT_SIZES` dictionary:
   ```python
   DISPLAY_FONT_SIZES = {
       (3440, 1440): "24",        # Your entry here
       (2056, 1329): "21.2",
       # ... other resolutions
   }
   ```

### Adjust Leader Key Timeout

In `leader.sh`, change the `-t 1` value to tune responsiveness:
- `-t 0.5`: Faster/snappier
- `-t 1`: Balanced (recommended)
- `-t 2`: More forgiving

## Troubleshooting

- **Font size not changing on display switch**: 
  - Ensure Yabai is installed: `brew install yabai`
  - Verify Yabai has System Events scripting permission
  - Or manually adjust with `Ctrl+Shift+=` / `Ctrl+Shift+-`

- **Remote control not working**:
  - Check `listen_on unix:/tmp/kitty` is enabled in `kitty.conf`
  - Verify no other Kitty instance is holding the socket

- **Sessions not loading**:
  - Ensure session files exist in `~/.config/kitty/sessions/`
  - Check file permissions: `chmod 600 ~/.config/kitty/sessions/*.kitty-session`

- **Leader keybinds timing out**:
  - Adjust timeout in `leader.sh` (increase `-t` value)
  - Or use explicit full sequences instead of waiting for follow-up keys

## Notes

- This config uses `shell_integration no-sudo` to prevent integration in sudo/remote contexts
- Copy-on-select is enabled for quick clipboard access
- Remote control via Unix socket enables scripted terminal manipulation
- PowerLine tab styling provides visual indication of active session
