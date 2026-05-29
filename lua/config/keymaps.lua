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

vim.api.nvim_create_user_command("DumpHotkeys", function()
  local raw = {}
  local leader = vim.g.mapleader or "\\"

  local COL_PKG = 20
  local COL_DESC = 45
  local COL_KEY = 25
  local COL_KEY1 = 10
  local COL_KEY2 = 10

  local function truncate(s, len)
    if #s > len then
      return s:sub(1, len - 1) .. "…"
    end
    return s
  end

  local function is_internal_name(s)
    if s:find("%s") then
      return false
    end
    local humps = 0
    for _ in s:gmatch("%u%l+") do
      humps = humps + 1
    end
    return humps >= 2
  end

  local function tokenise(lhs)
    local tokens = {}
    local i = 1
    while i <= #lhs do
      if lhs:sub(i, i) == "<" then
        local j = lhs:find(">", i, true)
        if j then
          table.insert(tokens, lhs:sub(i, j))
          i = j + 1
        else
          table.insert(tokens, lhs:sub(i, i))
          i = i + 1
        end
      else
        table.insert(tokens, lhs:sub(i, i))
        i = i + 1
      end
    end
    return tokens
  end

  local function extract_keys(display_lhs)
    local tokens = tokenise(display_lhs)
    local k1 = tokens[1] or ""
    local k2 = tokens[2] or nil
    if k1 == " " or k1 == leader then
      k1 = "<leader>"
    end
    if k2 and (k2 == " " or k2 == leader) then
      k2 = "<leader>"
    end
    return k1, k2
  end

  local plugin_patterns = {}
  local lhs_to_plugin = {}
  local ok, lazy_plugins = pcall(function()
    return require("lazy").plugins()
  end)
  if ok then
    for _, plugin in ipairs(lazy_plugins) do
      local name = plugin.name
      if name then
        table.insert(plugin_patterns, {
          pattern = name:lower():gsub("[%-%.%_]", "."),
          label = name,
        })
        if plugin.keys then
          for _, k in ipairs(plugin.keys) do
            local lhs = type(k) == "table" and k[1] or k
            if lhs then
              lhs_to_plugin[lhs] = name
            end
          end
        end
      end
    end
  end

  local function resolve_package(lhs, desc)
    local prefix = desc:match("^([%w%-%. ]+):%s*.+$")
    if prefix then
      return prefix:match("^%s*(.-)%s*$")
    end
    if lhs_to_plugin[lhs] then
      return lhs_to_plugin[lhs]
    end
    local desc_lower = desc:lower()
    for _, entry in ipairs(plugin_patterns) do
      if desc_lower:find(entry.pattern) then
        return entry.label
      end
    end
    return "global"
  end

  local function clean_desc(desc)
    return desc:match("^[%w%-%. ]+:%s*(.+)$") or desc
  end

  for _, mode in ipairs({ "n", "v", "x", "s", "o", "i", "c", "t" }) do
    for _, k in ipairs(vim.api.nvim_get_keymap(mode)) do
      local lhs = k.lhs
      if not lhs then
        goto continue
      end
      if lhs:match("^<[Pp]lug>") then
        goto continue
      end

      local raw_desc = k.desc or k.rhs or "<lua>"
      local desc = clean_desc(raw_desc)
      if is_internal_name(desc) then
        goto continue
      end

      local package = resolve_package(lhs, raw_desc)
      local display_lhs = lhs:gsub("<[Ll]eader>", leader)
      local k1, k2 = extract_keys(display_lhs)

      local dedup_key = lhs .. "||" .. raw_desc
      if not raw[dedup_key] then
        raw[dedup_key] = {
          lhs = display_lhs,
          desc = desc,
          package = package,
          k1 = k1,
          k2 = k2,
          modes = {},
        }
      end
      local seen = false
      for _, m in ipairs(raw[dedup_key].modes) do
        if m == mode then
          seen = true
          break
        end
      end
      if not seen then
        table.insert(raw[dedup_key].modes, mode)
      end

      ::continue::
    end
  end

  local lines = {}
  for _, entry in pairs(raw) do
    table.sort(entry.modes)
    local modes = "[" .. table.concat(entry.modes, "+") .. "]"
    table.insert(
      lines,
      string.format(
        "%-"
          .. COL_PKG
          .. "s  %-"
          .. COL_DESC
          .. "s  %-"
          .. COL_KEY
          .. "s  %-"
          .. COL_KEY1
          .. "s  %-"
          .. COL_KEY2
          .. "s  %s",
        truncate(entry.package, COL_PKG),
        truncate(entry.desc, COL_DESC),
        truncate(entry.lhs, COL_KEY),
        entry.k1,
        entry.k2 or "-",
        modes
      )
    )
  end

  table.sort(lines, function(a, b)
    return a < b
  end)

  local header = string.format(
    "%-"
      .. COL_PKG
      .. "s  %-"
      .. COL_DESC
      .. "s  %-"
      .. COL_KEY
      .. "s  %-"
      .. COL_KEY1
      .. "s  %-"
      .. COL_KEY2
      .. "s  %s",
    "PACKAGE",
    "DESCRIPTION",
    "KEY",
    "KEY-1",
    "KEY-2",
    "MODES"
  )
  local divider = string.rep("-", COL_PKG + COL_DESC + COL_KEY + COL_KEY1 + COL_KEY2 + 16)
  table.insert(lines, 1, divider)
  table.insert(lines, 1, header)

  vim.fn.writefile(lines, "/tmp/hotkeys.txt")
  vim.notify("Dumped " .. (#lines - 2) .. " keymaps → /tmp/hotkeys.txt", vim.log.levels.INFO)
end, { desc = "Dump all keymaps to /tmp/hotkeys.txt" })

map("n", "<leader>Dk", "<cmd>DumpHotkeys<cr>", { desc = "Dump all hotkeys to file" })
