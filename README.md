# Dotfiles

Personal macOS configuration managed with [yadm](https://yadm.io/). The repository
uses the home directory as its working tree, so paths such as `.config/nvim`
match their installed locations.

Only explicitly tracked files belong to this repository. The local `.config`
directory also contains untracked settings, application state, and credentials;
its contents should not be treated as a complete inventory of this repository.

## Configuration Guides

Each guide covers the dependencies, setup, keybindings, and maintenance for its
component.

| Component | Guide |
| --- | --- |
| Neovim | [Terminal configuration and VS Code integration](.config/nvim/README.md) |
| Kitty | [Terminal sessions, navigation, and display-aware font sizing](.config/kitty/README.md) |
| Zsh | [Shell startup, tools, aliases, and custom functions](.config/zsh/README.md) |
| AeroSpace | [Hyper-key window management, workspaces, and app routing](.config/aerospace/README.md) |
| Borders | [Active/inactive window outlines and service management](.config/borders/README.md) |

Additional component guides can be linked here as they are documented.

## Setup

Install yadm on macOS:

```sh
brew install yadm
```

On a new machine, clone this dotfiles repository using yadm, substituting its
actual URL:

```sh
yadm clone "<DOTFILES_REPOSITORY_URL>"
```

Review existing files before cloning into a populated home directory. Do not
force-overwrite local configuration. On a machine already managed by yadm, use
the existing checkout rather than cloning again.

Cloning restores tracked configuration, not applications, downloaded plugins,
or every local setting. Follow the component guides above to install dependencies
and finish setup. Review machine-specific paths and optional integrations before
using the configuration on another computer.

## Maintenance

Run these commands from the home directory:

```sh
cd ~
yadm ls-files
yadm status
yadm diff
```

Stage intentional changes by explicit path. For example, to include the current
documentation:

```sh
yadm add README.md .config/nvim/README.md .config/kitty/README.md
yadm diff --cached
```

Commit and push reviewed changes through yadm when ready. Avoid broad commands
such as `yadm add .` or staging all of `.config`; they can include unrelated
application data or secrets. Never commit tokens, credentials, or private keys.