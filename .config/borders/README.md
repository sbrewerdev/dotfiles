# Borders

[JankyBorders](https://github.com/FelixKratz/JankyBorders) draws outlines around
macOS windows to distinguish active and inactive windows. This setup complements
[AeroSpace](../aerospace/README.md), but runs as a separate process.

## Setup

Install Borders through Homebrew:

```sh
brew install felixkratz/formulae/borders
```

Restore [bordersrc](bordersrc) through yadm to `~/.config/borders/bordersrc`.
Borders uses this executable shell script for its configuration. If restoring
it loses the executable bit, restore it with:

```sh
chmod +x ~/.config/borders/bordersrc
```

To run Borders as a managed background service:

```sh
brew services start borders
```

Alternatively, launch `borders` manually. Use one startup mechanism rather than
running a manual instance alongside the service. Follow the installed version's
requirements if macOS reports a permission or compatibility issue.

## Appearance

The active `options` array in [bordersrc](bordersrc) sets:

| Setting | Value | Appearance |
| --- | --- | --- |
| `active_color` | `0xff29a329` | Opaque green for the active window |
| `inactive_color` | `0xff3E1C9E` | Opaque purple for inactive windows |
| `width` | `5.0` | Border width |

Colors use `0xAARRGGBB`: alpha, red, green, and blue. The leading `ff` makes
these colors fully opaque. A second palette is commented out and has no effect.

To change appearance, edit the active array and restart the service:

```sh
brew services restart borders
```

The script ends with `borders "${options[@]}"`, forwarding the array entries as
individual command-line options. It uses Bash array syntax, so do not run it
with `sh`.

## AeroSpace Integration

[The AeroSpace config](../aerospace/aerospace.toml) contains a commented Borders
startup command. It is inactive: AeroSpace does not currently launch Borders.
The service reads this directory's configuration independently of AeroSpace's
keybindings or workspace rules.

If you later enable the AeroSpace startup hook, review any inline color/width
options and decide which startup mechanism owns Borders. The commented hook's
colors differ from the active palette here.

## Troubleshooting And Maintenance

Check service status or stop the background process:

```sh
brew services list
brew services stop borders
```

If borders do not appear, confirm the service is running, `borders` is installed,
and the config script is executable. If colors do not match this guide, check
for command-line overrides or another startup mechanism.

Validate the script's syntax without launching Borders:

```sh
bash -n ~/.config/borders/bordersrc
```

Review and stage explicit files through yadm:

```sh
cd ~
yadm status -- .config/borders README.md
yadm diff -- .config/borders README.md
yadm add .config/borders/README.md README.md
```

Stage [bordersrc](bordersrc) separately when changing appearance. See the
[dotfiles overview](../../README.md) for the other component guides.