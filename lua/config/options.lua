-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

-- LSP Server to use for Python.
-- Set to "basedpyright" to use basedpyright instead of pyright.
-- vim.g.lazyvim_python_lsp = "pyright"
-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"

-- Clipboard configuration for X11 and Wayland
if vim.fn.has("unix") == 1 then
  if vim.env.WAYLAND_DISPLAY then
    -- Wayland clipboard configuration
    vim.g.clipboard = {
      name = "wl-clipboard",
      copy = {
        ["+"] = "wl-copy",
        ["*"] = "wl-copy --primary",
      },
      paste = {
        ["+"] = "wl-paste --no-newline",
        ["*"] = "wl-paste --primary --no-newline",
      },
      cache_enabled = 0,
    }
  elseif vim.env.DISPLAY then
    -- X11 clipboard configuration
    vim.g.clipboard = {
      name = "xclip-clipboard",
      copy = {
        ["+"] = "xsel --clipboard --input",
        ["*"] = "xsel --primary --input",      },
      paste = {
        ["+"] = "xsel --clipboard --output",
        ["*"] = "xsel --primary --output",
            },
      cache_enabled = 0,
    }
  -- Ensure middle mouse works by syncing yanks to primary
  vim.opt.clipboard:append("unnamed")

  -- not adding noise 
  --vim.notify("Clipboard set to xsel for X11 with unnamed sync", vim.log.levels.INFO, { title = "Clipboard Config" })

  end
end
