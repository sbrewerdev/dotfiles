# Neovim

Personal Neovim configuration for terminal editing and the VS Code Neovim
extension. This directory is part of a yadm-managed dotfiles collection, not a
separate repository. Files present locally are not necessarily tracked or
published.

## Requirements

- A recent Neovim build with `vim.pack`, `vim.lsp.config`, `vim.lsp.enable`, and
  `vim._core.ui2`. Terminal startup was tested with Neovim 0.12.6. The UI module
  is internal, so compatibility with other versions is not guaranteed.
- Git and internet access for initial plugin installation.
- Language-specific runtimes needed by Mason packages, such as Node.js/npm for
  JavaScript-based servers and tools. C# tooling also needs a suitable .NET SDK.
- A C compiler and the tree-sitter CLI for building Treesitter parsers.
- Optional: a Nerd Font for icons and a GitHub Copilot subscription or eligible
  account for Copilot suggestions.

On macOS, Homebrew can install the main prerequisites:

```sh
brew install neovim git node tree-sitter-cli
xcode-select --install
nvim --version
```

Skip the developer-tools installation if they are already installed. Confirm
that your Neovim version provides the APIs above before using this config.

## Setup

Restore the tracked files with your existing yadm workflow. The expected config
location is `~/.config/nvim`; do not clone another repository over this directory.

```sh
nvim
```

Terminal startup uses `vim.pack.add()` to install missing plugins. Mason installs
configured language servers and tools, and Treesitter installs configured
parsers. Allow first-run downloads to finish before restarting Neovim.

Useful checks inside terminal Neovim:

```vim
:checkhealth
:Mason
:checkhealth vim.lsp
```

Mason requests Lua, TypeScript/JavaScript, HTML, CSS, and JSON language servers,
plus Prettier, Stylua, CSharpier, and xmlformatter. Installation does not imply
that every tool is wired into formatting or every server is configured for a
project. C# / Roslyn configuration is also present, but Roslyn is not in the
automatic installation list; inspect [the LSP module](lua/plugins/lsp.lua) when
setting up a C# environment.

## Configuration Layout

| File or directory | Purpose |
| --- | --- |
| [init.lua](init.lua) | Selects VS Code or terminal startup |
| [Core loader](lua/core/init.lua) | Loads terminal options, keymaps, and autocmds |
| [Options](lua/core/options.lua) | Terminal settings and a small VS Code subset |
| [Keymaps](lua/core/keymaps.lua) | Shared editing keys and environment-specific navigation |
| [Autocmds](lua/core/autocmds.lua) | Wrapping and spellchecking for text, Markdown, and commits |
| [Plugin loader](lua/plugins/init.lua) | Loads the terminal plugin modules |
| [Current theme](lua/current-theme.lua) | Selects `blueberry-peach` |
| [nvim-pack-lock.json](nvim-pack-lock.json) | Built-in package manager lockfile |
| [snippets](snippets) | Local LuaSnip snippets |
| [after](after) | Filetype-specific overrides |

Terminal plugins provide mini.nvim editing and UI helpers, which-key hints, Oil
file browsing, Treesitter, Mason/LSP, Blink completion, LuaSnip, Markdown
rendering and image integrations, inline diagnostics, and Copilot. See
[the plugin modules](lua/plugins) for their individual settings and any optional
integration dependencies.

## Keymaps

The leader and local leader are both **Space**. Keys below are in normal mode
unless otherwise noted.

| Key | Action |
| --- | --- |
| `jk` in insert mode | Exit insert mode; terminal mapping also moves right |
| `Space nh` | Clear search highlights |
| `Ctrl-d` / `Ctrl-u` | Scroll half a page and center the cursor |
| `n` / `N` | Search next/previous and center the match |
| `J` / `K` in visual mode | Move selected lines down/up |
| `<` / `>` in visual mode | Indent and retain selection |
| `p` in visual mode | Paste without replacing the source register |
| `-` | Open Oil in terminal Neovim; focus Explorer in VS Code |
| `H` / `L` | Previous/next buffer in terminal; previous/next editor in VS Code |
| `Ctrl-h/j/k/l` | Focus the window/editor group left/down/up/right |
| `Space ww` | Focus the previous window/editor group |
| `Space wd` | Close a terminal window or the active VS Code editor |
| `Space w-` / `Space w\|` | Split below/right |

Additional terminal-only keys:

| Key | Action |
| --- | --- |
| `Space -` | Floating Oil explorer |
| `Ctrl-Shift-Up/Down/Left/Right` | Resize windows |
| `zv` | Close other folds and reveal the cursor's fold |
| `Space pu` | Update plugins with `vim.pack.update()` |
| `Ctrl-g` in insert mode | Accept a Copilot suggestion |
| `Space ge` / `Space gd` / `Space gs` | Enable/disable/check Copilot |
| `Space ip` | Paste an image through the Markdown image integration |

For terminal Copilot, run `:Copilot setup` to authenticate. LSP-specific mappings
are defined in [the LSP module](lua/plugins/lsp.lua); their availability depends
on the attached server and its configuration.

## VS Code

Install the **VSCode Neovim** extension (`asvetliakov.vscode-neovim`). It sets
`vim.g.vscode`, which makes [init.lua](init.lua) load only the options and keymaps
modules, then return. Terminal UI, plugins, theme, and core autocmds are skipped.
VS Code supplies its own UI, completion, diagnostics, and language tooling.

If the extension cannot find Neovim or this config, merge these entries into
**Preferences: Open User Settings (JSON)**, adjusting paths for your machine:

```json
{
    "vscode-neovim.neovimExecutablePaths.darwin": "/opt/homebrew/bin/nvim",
    "vscode-neovim.neovimInitVimPaths.darwin": "/Users/YOUR_USER/.config/nvim/init.lua",
    "vscode-neovim.compositeKeys": {
        "jk": {
            "command": "vscode-neovim.escape",
            "args": []
        }
    }
}
```

VS Code handles insert-mode typing, so the Lua `jk` mapping alone is insufficient.
The composite binding above exits insert mode when `jk` is typed within the
default 300 ms interval. Adjust `vscode-neovim.compositeTimeout` if needed.

Open the Command Palette with **Cmd+Shift+P** and run **Developer: Reload Window**
after changing the startup config. To verify detection, run this from the
extension's Neovim command line:

```vim
:lua print(vim.g.vscode)
```

It should print `1`. VS Code user settings live outside this Neovim directory
and must be restored or tracked separately.

## Maintenance And Yadm

Use `Space pu` or `:lua vim.pack.update()` in terminal Neovim to update plugins.
Review the resulting lockfile changes, and restart Neovim after updates. Edit
[the current-theme module](lua/current-theme.lua) to switch among the installed
colorschemes.

Run yadm commands from your home directory so paths are relative to the dotfiles
repository root:

```sh
cd ~
yadm ls-files -- .config/nvim
yadm status -- .config/nvim
yadm diff -- .config/nvim
```

To include this README or selected config changes, stage explicit paths rather
than all of `~/.config`:

```sh
yadm add .config/nvim/README.md
# When intentionally updating plugin versions:
yadm add .config/nvim/nvim-pack-lock.json
```

Installed plugins and language servers normally live under Neovim's data
directory, not this config directory, and do not need to be committed. Avoid
tracking credentials or unrelated local configuration.

A future README at the dotfiles repository root can link here with:

```markdown
[Neovim](.config/nvim/README.md)
```