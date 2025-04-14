return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "moon" },
  },
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      overrides = {
        ["@comment"] = { bg = "#1e1e1e" }, -- Default background for comments
      },
    },
    config = function()
      -- Function to set comment highlight based on mode
      local function set_comment_highlight()
        local mode = vim.fn.mode()
        if mode == "n" then
          vim.api.nvim_set_hl(0, "@comment", { bg = "#004d00" }) -- Deep green for normal mode
        else
          vim.api.nvim_set_hl(0, "@comment", { bg = "#1e1e1e" }) -- Default for other modes
        end
      end

      -- Initial highlight setup
      set_comment_highlight()

      -- Autocommand to update highlight on mode change
      vim.api.nvim_create_autocmd({ "ModeChanged" }, {
        pattern = "*",
        callback = set_comment_highlight,
      })
    end,
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
