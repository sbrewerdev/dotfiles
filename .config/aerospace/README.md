# AeroSpace

macOS tiling window management configured in [aerospace.toml](aerospace.toml).
The setup uses named workspaces, application routing, multi-monitor assignments,
and a Raycast-managed Hyper key. See also the [Borders guide](../borders/README.md)
for active/inactive window outlines.

## Setup

Install [AeroSpace](https://nikitabobko.github.io/AeroSpace/guide) through Homebrew:

```sh
brew install --cask nikitabobko/tap/aerospace
open -a AeroSpace
```

Grant AeroSpace Accessibility access in **System Settings > Privacy & Security >
Accessibility** when prompted. Restore this config through yadm to
`~/.config/aerospace/aerospace.toml`. Use an AeroSpace version that supports
`config-version = 2` and the commands in this file; older releases may reject it.

Configuration changes reload automatically because `auto-reload-config = true`.
For a manual reload while AeroSpace is running:

```sh
aerospace reload-config
```

`start-at-login = false`, so this config does not request automatic login startup.
Launch AeroSpace manually or configure your preferred startup mechanism.

## Hyper Key

**Hyper means Ctrl+Cmd+Alt in this setup, without Shift.** Raycast maps
**holding Caps Lock** to that modifier chord. AeroSpace only defines shortcuts
for the chord; it does not implement the Caps Lock remap.

Configure the same Hyper key in Raycast on a new machine, or press Ctrl+Cmd+Alt
directly. Bindings written as **Hyper+Shift** require Shift in addition to
holding Caps Lock. Raycast's remap must be active for Caps Lock shortcuts to work.

## Main Keybindings

The key-mapping preset is `qwerty`.

| Shortcut | Action |
| --- | --- |
| Hyper+`/` | Cycle tiled layout orientation |
| Hyper+`,` | Cycle accordion layout orientation |
| Hyper+`h/j/k/l` | Focus left/down/up/right |
| Hyper+Shift+`h/j/k/l` | Move the focused window left/down/up/right |
| Hyper+`-` / Hyper+`=` | Resize smaller/larger by 50 |
| Hyper+Shift+`f` | Toggle AeroSpace fullscreen |
| Hyper+workspace key | Switch to that workspace |
| Hyper+Shift+workspace key | Move the focused window to that workspace |
| Hyper+Tab | Switch between current and previous workspace |
| Hyper+Shift+Tab | Move the current workspace to the next monitor, wrapping around |
| Ctrl+Alt+Left / Ctrl+Alt+Right | Move the current workspace to the previous/next monitor |
| Hyper+Shift+`;` | Enter service mode |

Workspace keys are `1` through `9`, plus `A B C D E M N O P R S T U V Z`.
Moving a window to a workspace does not include a separate command to follow it.

## Service Mode

Enter with **Hyper+Shift+`;`**, then use one of these keys. Each action returns
to main mode.

| Key | Action |
| --- | --- |
| Esc | Reload config and leave service mode |
| `r` | Flatten/reset the current workspace tree |
| `f` | Toggle the focused window between floating and tiled |
| Backspace | Close all windows on the workspace except the focused one |
| Alt+Shift+`h/j/k/l` | Join containers left/down/up/right |
| `h/j/k/l` | Swap windows left/down/up/right without changing the layout hierarchy |

**Backspace closes other windows**, rather than merely hiding or moving them.

## Workspaces And Application Routing

Rules in `on-window-detected` route matching newly detected windows:

| Workspace | Applications |
| --- | --- |
| A | Krisp |
| B | Zen Browser |
| C | Microsoft Teams |
| D | JetBrains DataGrip |
| E | Microsoft Excel |
| M | Apple Messages and the configured Android SMS app |
| O | WPS Office |
| P | Applications matching the Parallels name rule |
| R | JetBrains Rider |
| S | Spotify |
| T | Kitty, WezTerm, and Ghostty |
| V | Visual Studio Code |
| W | Microsoft Word |
| Z | Zoom |

The config also keeps numeric workspaces and several unassigned letter
workspaces persistent. **W is routed but is not in the persistent-workspace list
or the workspace keybindings.** Switch to it with `aerospace workspace W`, or
add consistent bindings and persistence if you want direct keyboard access.

Finder, iTerm2, Shottr, Preview, and the matching Krisp notification window are
configured to float. Application rules depend on bundle IDs/names; review the
actual matches in [aerospace.toml](aerospace.toml) when an app does not route as
expected. Routed windows do not automatically switch your focused workspace.

## Monitors, Layout, And Gaps

Numeric workspaces have forced monitor assignments, with fallback preferences:

| Workspaces | Monitor preference |
| --- | --- |
| 1, 5, 9 | 1 |
| 2, 6 | 2, then 1 |
| 3, 7 | 3, then 2, then 1 |
| 4, 8 | 4, then 3, then 2, then 1 |

These numbers refer to AeroSpace's monitor ordering, not permanent display IDs.
Review forced assignments when rearranging displays or moving workspaces.

Defaults are tiled layout with automatic root orientation, container
normalization enabled, and accordion padding of 30. Inner gaps are 8; outer
left/right gaps are 6 and the bottom gap is 12. The top gap is 10 on monitors
matching `U32J59x`, otherwise 6.

The pointer lazily moves to the focused window's center. Focus-follows-mouse is
disabled, and hidden macOS applications are not automatically unhidden.

## Borders Integration

The Borders launch command in `after-startup-command` is commented out, leaving
no active startup commands. AeroSpace does **not** start Borders with the current
configuration. Run Borders separately, normally through Homebrew services as
described in [its guide](../borders/README.md). Avoid enabling a second startup
mechanism accidentally.

## Maintenance And Troubleshooting

If shortcuts fail, confirm AeroSpace is running, Accessibility access is granted,
and Raycast is producing Ctrl+Cmd+Alt when Caps Lock is held. Try the modifier
chord directly to distinguish an AeroSpace binding issue from a Hyper-key issue.
Check the active binding mode if ordinary shortcuts stop responding; Esc leaves
service mode and reloads the config.

After editing routing or monitor rules, reload and test with an appropriate
window or workspace. A reload is not a promise to reroute every existing window.

Review and stage intentional changes through yadm:

```sh
cd ~
yadm status -- .config/aerospace README.md
yadm diff -- .config/aerospace README.md
yadm add .config/aerospace/README.md README.md
```

Stage [aerospace.toml](aerospace.toml) separately when changing behavior. See the
[dotfiles overview](../../README.md) for the other configuration guides.