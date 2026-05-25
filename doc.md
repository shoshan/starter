
# Neovim Configuration Documentation

## Overview
This repository contains a Neovim configuration based on LazyVim and custom plugin settings. The config focuses on:
-  ai gemini connector avante
- Python LSP integration with `pyright` and `ruff`
- Clipboard support for Wayland and X11
- Custom colorscheme loading and highlight tweaks
- `fzf-lua` UI and search behavior
- `tmux` navigation hotkeys
- Performance tuning and plugin management

## Core Configuration

### `config/options.lua`

#### Python LSP Selection
- `vim.g.lazyvim_python_ruff = "ruff"` enables the optional `ruff` LSP integration.
- `vim.g.lazyvim_python_lsp` is mentioned as a configurable value for choosing the Python LSP server.

#### Clipboard Integration
- Detects Unix environment via `vim.fn.has("unix") == 1`.
- If running under Wayland (`WAYLAND_DISPLAY`):
  - Uses `wl-copy`/`wl-paste` for `+` and `*` register support.
  - Disables clipboard cache with `cache_enabled = 0`.
- If running under X11 (`DISPLAY`):
  - Uses `xsel` for clipboard operations.
  - Syncs yanks to the primary selection with `vim.opt.clipboard:append("unnamed")`.
- The X11 notify message is intentionally commented out to avoid noise.

### `config/lazy.lua`

This file bootstraps `lazy.nvim` and configures plugin loading.

#### Lazy.nvim setup
- Ensures `lazy.nvim` is installed under `stdpath('data')`.
- Prepends the lazy runtime path and calls `require("lazy").setup()`.
- Imports:
  - `LazyVim/LazyVim` core config and plugins
  - Local plugin modules from `plugins`

#### Defaults
- `lazy = false`
  - Custom plugins load at startup instead of being lazy-loaded by default.
- `version = false`
  - Always uses the latest commit for plugins rather than pinned releases.

#### Install / update behavior
- Installs fallback colorschemes: `tokyonight` and `habamax`.
- Enables periodic plugin update checks with `checker.enabled = true`.
- Suppresses update notifications with `checker.notify = false`.

#### Performance tuning
- Disables built-in runtime plugins:
  - `gzip`
  - `tarPlugin`
  - `tohtml`
  - `tutor`
  - `zipPlugin`
- `matchit`, `matchparen`, and `netrwPlugin` are present but commented out.

## Plugin Features

### `plugins/colorscheme.lua`
- Loads `folke/tokyonight.nvim` lazily with `style = "moon"`.
- Configures `ellisonleao/gruvbox.nvim` with custom highlight overrides for comments.
- Adds dynamic Normal background adjustment based on mode using `ModeChanged` autocommand.
- Sets the active colorscheme to `gruvbox` via LazyVim options.

### `plugins/fzf.lua`
- Loads `ibhagwan/fzf-lua` on the `FzfLua` command.
- Customizes FZF formatting and window layout.
- Configures UI select prompts with centered titles and optional code action preview layouts.
- Sets search windows to 99% width and 80% height.
- Adds key bindings for file/grep actions:
  - `alt-i` toggles ignore patterns
  - `alt-h` toggles hidden files
- Configures LSP symbol formatting and preview behavior.
- Uses `delta` as a code action previewer if it is installed.

### `plugins/tmux_nav.lua`
- Loads `christoomey/vim-tmux-navigator` for tmux pane navigation.
- Defines command-based loading for navigation commands.
- Maps keys:
  - `<c-h>` → `TmuxNavigateLeft`
  - `<c-j>` → `TmuxNavigateDown`
  - `<c-k>` → `TmuxNavigateUp`
  - `<c-l>` → `TmuxNavigateRight`
  - `<c-\>` → `TmuxNavigatePrevious`

### `plugins/lspconfig.lua`
- Extends `neovim/nvim-lspconfig` settings for Python LSP servers.
- Ensures both `pyright` and `ruff` servers exist in `opts.servers`.
- Uses environment-based Mason install logic:
  - On `CPU_MODEL == "Raspberry Pi"`, only `ruff` is marked for Mason installation.
  - Otherwise, both `pyright` and `ruff` are installed via Mason.

#### Ruff attachment behavior
- Adds a `LspAttach` autocmd specifically for the active `ruff` server.
- When `ruff` attaches, it disables `hoverProvider` to let `pyright` handle hover documentation.

### `plugins/disable.lua`
- Contains placeholder configuration for disabling plugins.
- Currently no plugins are disabled by default.
- Includes an example commented-out disable entry for `steavearc/conform`.

## Notes
- The config is designed to be lightweight and customizable, with a strong focus on Python tooling and cross-platform clipboard support.
- Most plugin behavior is delegated through LazyVim, with local overrides and enhancements provided in the `plugins/` modules.

