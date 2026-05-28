-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--from dpetka
local map = vim.keymap.set
local del = vim.keymap.del

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                        delete some lazy keymaps                   │
--     ╰───────────────────────────────────────────────────────────────────╯
del("n", "<leader>L")
del("n", "<leader>l")

map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename" })

local right_pane = {
  preview = false,
  layout = {
    layout = { -- box definition goes here, not at top level
      backdrop = false,
      width = 0.3,
      min_width = 40,
      height = 1,
      position = "right",
      border = "rounded",
      box = "vertical",
      { win = "input", height = 1, border = "bottom" },
      { win = "list", border = "none" },
    },
  },
}

map("n", "<leader>hp", function()
  local buf = vim.api.nvim_get_current_buf()
  Snacks.picker.keymaps(vim.tbl_extend("force", right_pane, {
    title = "Command Palette",
    buf = buf,
    global = true,
    local_ = true,
    filter = function(item)
      local desc = item.desc or ""
      return desc ~= "" and not desc:match("^'[nN][nN]'") and not desc:match("^<Cmd>") and not desc:match("^:[^%a]")
    end,
    format = function(item, _picker)
      local desc = item.desc or item.rhs or "?"
      local lhs = (item.lhs or ""):gsub("%s+", "")
      local mode = item.mode or " "
      local max_desc = 45
      local truncated = #desc > max_desc and desc:sub(1, max_desc - 1) .. "…" or desc
      local pad = string.rep(" ", math.max(1, max_desc - #truncated))
      return {
        { mode .. "  ", "Comment" },
        { truncated, "Normal" },
        { pad, "Normal" },
        { lhs, "Special" },
      }
    end,
  }))
end, { desc = "Command Palette" })

map("n", "<leader>hk", function()
  local buf = vim.api.nvim_get_current_buf()
  Snacks.picker.keymaps(vim.tbl_extend("force", right_pane, { buf = buf }))
end, { desc = "Search Keymaps" })
