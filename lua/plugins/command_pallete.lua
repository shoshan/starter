return {
  {
    "mrjones2014/legendary.nvim",
    version = "v2.x.x",
    dependencies = { "kkharji/sqlite.lua" },
    opts = {
      extensions = {
        lazy_nvim = true, -- Pulls all your LazyVim plugins
        which_key = true, -- Pulls your current key descriptions
      },
    },
    config = function(_, opts)
      -- Initialize legendary
      require("legendary").setup(opts)

      -- Create the VS Code style Side Pane function
      local function open_palette_in_side_pane()
        -- 1. Create a vertical split on the right side, 40 columns wide
        vim.cmd("botright vsplit")
        vim.cmd("vertical resize 40")

        -- 2. Prevent this side window from messing up your code layouts
        vim.wo.winfixwidth = true

        -- 3. Launch Legendary inside this specific newly created window pane
        require("legendary").find({
          -- This forces legendary to use the current window instead of a floating popup
          formatter = nil,
        })
      end

      -- Map Ctrl+Shift+P to open the panel (Just like VS Code)

      vim.keymap.set("n", "<C-S-O>", open_palette_in_side_pane, { desc = "VS Code Command Palette Pane" })
    end,
  },
}
