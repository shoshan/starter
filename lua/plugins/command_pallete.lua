return {
  {
    "mrjones2014/legendary.nvim",
    version = "v2.x.x",
    dependencies = {
      "kkharji/sqlite.lua",
      "ibhagwan/fzf-lua",
    },
    opts = {
      extensions = {
        lazy_nvim = true,
        which_key = true,
      },
      -- Use fzf-lua as the vim.ui.select handler for legendary
      select = function(items, opts, on_choice)
        opts = opts or {}
        local fzf_items = {}
        local item_map = {}

        for i, item in ipairs(items) do
          local text = item[1] or item.text or tostring(item)
          local desc = opts.format_item and opts.format_item(item) or text
          table.insert(fzf_items, desc)
          item_map[desc] = item
        end

        require("fzf-lua").fzf_exec(fzf_items, {
          prompt = opts.prompt or "Command Palette> ",
          actions = {
            ["default"] = function(selected)
              if selected and selected[1] then
                local choice = item_map[selected[1]]
                if choice and on_choice then
                  on_choice(choice)
                end
              end
            end,
          },
          winopts = {
            height = 0.65,
            width = 0.85,
            row = 0.15,
            title = opts.prompt,
            title_pos = "center",
          },
        })
      end,
    },
    config = function(_, opts)
      require("legendary").setup(opts)

      -- Optional: Register fzf-lua globally as vim.ui.select (recommended by legendary)
      require("fzf-lua").register_ui_select()

      -- Keymap for Command Palette
      vim.keymap.set("n", "<leader>hc", function()
        require("legendary").find()
      end, { desc = "VS Code Command Palette (Legendary + fzf-lua)" })
    end,
  },
}
