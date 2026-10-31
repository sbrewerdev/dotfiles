# Zsh

Modular macOS shell configuration loaded by [~/.zprofile](../../.zprofile) and
[~/.zshrc](../../.zshrc). These entry points and the shared modules are tracked
with yadm. Optional machine-specific overrides belong in `local/` and should be
reviewed separately before tracking.

## Startup And Load Order

Both entry points set:

```sh
export ZSH_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
```

The default location is `~/.config/zsh`. If `XDG_CONFIG_HOME` is set, the modules
must exist in its `zsh` directory instead.

### Login Shells: ~/.zprofile

[~/.zprofile](../../.zprofile) loads these files in order:

1. [path.zsh](path.zsh): PATH entries and deduplication.
2. [env.zsh](env.zsh): editor and application config locations.
3. `local/profile.zsh`, if present: machine-specific login settings.

Login shells read this file; interactive non-login shells do not. An interactive
login shell reads `.zprofile` before `.zshrc`. Ordinary non-interactive shells
do not read `.zshrc`, so do not depend on its aliases or functions in scripts.

### Interactive Shells: ~/.zshrc

[~/.zshrc](../../.zshrc) loads these pieces in order:

1. Oh My Zsh from `~/.oh-my-zsh`, if installed, with the `git` plugin and no theme.
2. [tools.zsh](tools.zsh): optional tool initialization.
3. [aliases.zsh](aliases.zsh): command shortcuts.
4. [completions.zsh](completions.zsh): optional Git Extras completion.
5. All `functions/*.zsh` files in glob order.
6. All `local/*.zsh` files in glob order, except `local/profile.zsh`.

The function and local globs tolerate missing files. Shared module files are
sourced unconditionally, so restore them together with the entry points.

## Requirements And Setup

Zsh is the required shell. The config assumes an Apple Silicon Homebrew prefix
at `/opt/homebrew`; review hardcoded paths for Intel Macs or other systems.

Restore the tracked configuration through your existing yadm checkout. Use a
new login shell after restoring it:

```sh
exec zsh -l
```

This replaces the current shell and reloads both entry points. Finish any work
in that shell first. Opening a new terminal configured to start a login Zsh
shell is another option.

Optional integrations:

| Dependency | Behavior |
| --- | --- |
| [Oh My Zsh](https://ohmyz.sh/) at `~/.oh-my-zsh` | Initializes its `git` plugin; no Oh My Zsh theme |
| Starship | Initializes the prompt when `starship` is available |
| zoxide | Initializes smart directory navigation using `cd` as its command |
| `wt` | Initializes Git worktree shell integration when available |
| rbenv | Initializes Ruby version management when available |
| colorls | Replaces `ls` and provides the richer `ll` listing |
| Git Extras | Loads completion from its `/opt/homebrew` installation if present |
| sesh and fzf | Enables the interactive session picker |
| luit | Required when using the FilePro SSH helpers |

For example, Homebrew can install these commonly used optional tools:

```sh
brew install starship zoxide rbenv git-extras fzf
```

The integrations above are guarded, so missing optional tools do not prevent
shell startup. Aliases to other applications still require those applications
when invoked. Use each tool's own installation instructions for anything not
installed here, including Oh My Zsh and sesh.

## PATH And Environment

[path.zsh](path.zsh) keeps PATH entries unique using Zsh's `path` array. It
prepends `/opt/homebrew/bin`, `/opt/homebrew/sbin`, and `~/.config/scripts`, then
appends `~/.dotnet/tools`, `~/.cargo/bin`, and `~/.local/bin`. JetBrains Toolbox
scripts are appended if their directory exists.

[env.zsh](env.zsh) exports:

| Variable | Value |
| --- | --- |
| `EDITOR` | `nvim` |
| `STARSHIP_CONFIG` | `~/.config/starship/starship.toml` |
| `WEZTERM_CONFIG_FILE` | `~/.config/wezterm/wezterm.lua` |

These application paths and the scripts PATH entry use `$HOME/.config`, even
when `ZSH_CONFIG_DIR` points to a custom `XDG_CONFIG_HOME`.

## Aliases

Defined in [aliases.zsh](aliases.zsh):

| Alias | Command or purpose |
| --- | --- |
| `cl` | `clear` |
| `ff` | `fastfetch` |
| `mux` | `tmuxinator` |
| `nv` | `nvim` |
| `spotify` | `spotatui` |
| `ls` | `colorls --sd`, only when colorls is installed |
| `ll` | Detailed colorls listing; falls back to `ls -Al` |
| `dotnetx64` | Intel .NET executable, only if present at the configured path |
| `ss` | Screensaver script under `~/bin/bash-screensavers` |
| `brewvim` | Starts Neovim with `NVIM_APPNAME=brewvim` |
| `nvchad` | Starts Neovim with `NVIM_APPNAME=nvchad` |
| `ramboevim` | Starts Neovim with `NVIM_APPNAME=ramboevim` |
| `nv12` | Starts Neovim with `NVIM_APPNAME=nvim` |

The alternate Neovim aliases select separate config/data locations; they do not
install those configurations or select a different Neovim executable.

## Custom Functions

### Session Picker

[functions/sesh.zsh](functions/sesh.zsh) registers the `sesh-sessions` ZLE widget
only when both sesh and fzf are installed. Press **Alt+g** to choose a session
with fzf and connect through sesh. The binding is registered in the emacs,
vi-command, and vi-insert keymaps.

The terminal must send Alt/Option as an Escape prefix for this binding; pressing
**Esc**, then **g**, sends the same sequence. Cancelling the picker does not
connect to a session.

### SSH Helpers

[functions/ssh.zsh](functions/ssh.zsh) defines shortcuts for configured servers:

- `filepro`, `fpdev`, `fpstage`, and `fptest2`: connect as `$USER`, wrapping SSH
  with `luit -encoding CP437` for FilePro terminal encoding.
- `webprod`, `webqa`, `webqa2`, and `websandbox`: connect as `root`, with
  `TERM=linux` for terminal compatibility.

These helpers forward additional arguments after the SSH destination. They
require access to the configured servers and your own SSH authentication. Check
the function definitions before using them on a different machine or account.
FilePro helpers report an error if luit is unavailable.

## Local Overrides

Create `~/.config/zsh/local/` if needed:

```sh
mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/local"
```

Use `local/profile.zsh` for login-only PATH or environment overrides. Use other
`local/*.zsh` files for interactive aliases, functions, or settings. Local files
load after the shared configuration, allowing them to override shared values.

This is a convention, not a guarantee that yadm ignores the directory. Keep
secrets out of tracked files and verify tracking before staging local changes.

## Maintenance And Troubleshooting

Check syntax without sourcing the configuration or running its integrations:

```sh
for file in ~/.zprofile ~/.zshrc "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/*.zsh; do
    zsh -n "$file"
done
```

For a fresh full reload, use `exec zsh -l`. Repeatedly sourcing `.zshrc` can rerun
tool initialization, so a new shell is preferable when testing startup changes.
If PATH or exported variables are missing, confirm the terminal starts a login
shell. If an optional integration is missing, check its executable with
`command -v`, and confirm it is on PATH before `.zshrc` loads.

Review and stage explicit paths through yadm:

```sh
cd ~
yadm ls-files -- .zprofile .zshrc .config/zsh
yadm status -- .zprofile .zshrc .config/zsh README.md
yadm diff -- .zprofile .zshrc .config/zsh README.md
yadm add .config/zsh/README.md README.md
```

Stage modified shell files separately when intended. Avoid adding all of
`.config` or blindly staging `local/`. See the [dotfiles overview](../../README.md)
for the other component guides.