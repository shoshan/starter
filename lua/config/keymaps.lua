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
-- del("n", "<leader>z")

