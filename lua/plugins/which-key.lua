return {
  "folke/which-key.nvim",
  keys = {
    {
      "<leader>hh",
      function()
        require("which-key").show({ keys = "", loop = true })
      end,
      desc = "Hydra: Leader Keys",
      mode = "n",
    },

    -- ── <leader>h<key> — show hydra for each <leader><key> group ─────────
    {
      "<leader>ha",
      function()
        require("which-key").show({ keys = "<leader>a", loop = true })
      end,
      desc = "Avante AI (ask, edit, toggle, models…)",
      mode = "n",
    },
    {
      "<leader>hb",
      function()
        require("which-key").show({ keys = "<leader>b", loop = true })
      end,
      desc = "Buffers (delete, pin, pick, switch…)",
      mode = "n",
    },
    {
      "<leader>hc",
      function()
        require("which-key").show({ keys = "<leader>c", loop = true })
      end,
      desc = "Code (format, LSP, mason, symbols…)",
      mode = "n",
    },
    {
      "<leader>hd",
      function()
        require("which-key").show({ keys = "<leader>d", loop = true })
      end,
      desc = "Debug / Profiler",
      mode = "n",
    },
    {
      "<leader>hf",
      function()
        require("which-key").show({ keys = "<leader>f", loop = true })
      end,
      desc = "Files & Find (open, recent, explorer, terminal)",
      mode = "n",
    },
    {
      "<leader>hg",
      function()
        require("which-key").show({ keys = "<leader>g", loop = true })
      end,
      desc = "Git (lazygit, blame, diff, log, PRs, issues…)",
      mode = "n",
    },
    {
      "<leader>hs",
      function()
        require("which-key").show({ keys = "<leader>s", loop = true })
      end,
      desc = "Search / Telescope (grep, marks, registers…)",
      mode = "n",
    },
    {
      "<leader>hu",
      function()
        require("which-key").show({ keys = "<leader>u", loop = true })
      end,
      desc = "UI Toggles (format, diagnostics, zen, numbers…)",
      mode = "n",
    },
    {
      "<leader>hq",
      function()
        require("which-key").show({ keys = "<leader>q", loop = true })
      end,
      desc = "Sessions (quit, restore, save…)",
      mode = "n",
    },
    {
      "<leader>hx",
      function()
        require("which-key").show({ keys = "<leader>x", loop = true })
      end,
      desc = "Trouble / Diagnostics lists",
      mode = "n",
    },
    {
      "<leader>hw",
      function()
        require("which-key").show({ keys = "<leader>w", loop = true })
      end,
      desc = "Windows (delete, zoom, split…)",
      mode = "n",
    },
    {
      "<leader>hT",
      function()
        require("which-key").show({ keys = "<leader><Tab>", loop = true })
      end,
      desc = "Tabs (new, close, next, prev, first, last…)",
      mode = "n",
    },
    {
      "<leader>hn",
      function()
        require("which-key").show({ keys = "<leader>n", loop = true })
      end,
      desc = "Notifications",
      mode = "n",
    },
    {
      "<leader>hr",
      function()
        require("which-key").show({ keys = "<leader>r", loop = true })
      end,
      desc = "LSP Rename",
      mode = "n",
    },

    -- ── <leader>H<key> — global groups (], [, g prefixes) ────────────────
    {
      "<leader>Ha",
      function()
        require("which-key").show({ keys = "<leader>a", loop = true })
      end,
      desc = "Avante AI commands",
      mode = "n",
    },
    {
      "<leader>Hb",
      function()
        require("which-key").show({ keys = "<leader>b", loop = true })
      end,
      desc = "Buffer management commands",
      mode = "n",
    },
    {
      "<leader>Hc",
      function()
        require("which-key").show({ keys = "<leader>c", loop = true })
      end,
      desc = "Code / LSP commands",
      mode = "n",
    },
    {
      "<leader>Hd",
      function()
        require("which-key").show({ keys = "<leader>d", loop = true })
      end,
      desc = "Debug / Profiler commands",
      mode = "n",
    },
    {
      "<leader>Hf",
      function()
        require("which-key").show({ keys = "<leader>f", loop = true })
      end,
      desc = "File finder commands",
      mode = "n",
    },
    {
      "<leader>Hg",
      function()
        require("which-key").show({ keys = "<leader>g", loop = true })
      end,
      desc = "Git commands",
      mode = "n",
    },
    {
      "<leader>Hs",
      function()
        require("which-key").show({ keys = "<leader>s", loop = true })
      end,
      desc = "Search picker commands",
      mode = "n",
    },
    {
      "<leader>Hu",
      function()
        require("which-key").show({ keys = "<leader>u", loop = true })
      end,
      desc = "UI toggle commands",
      mode = "n",
    },
    {
      "<leader>Hq",
      function()
        require("which-key").show({ keys = "<leader>q", loop = true })
      end,
      desc = "Session commands",
      mode = "n",
    },
    {
      "<leader>Hx",
      function()
        require("which-key").show({ keys = "<leader>x", loop = true })
      end,
      desc = "Trouble / diagnostics commands",
      mode = "n",
    },
    {
      "<leader>Hw",
      function()
        require("which-key").show({ keys = "<leader>w", loop = true })
      end,
      desc = "Window commands",
      mode = "n",
    },
    {
      "<leader>HT",
      function()
        require("which-key").show({ keys = "<leader><Tab>", loop = true })
      end,
      desc = "Tab commands",
      mode = "n",
    },
    {
      "<leader>Hn",
      function()
        require("which-key").show({ keys = "<leader>n", loop = true })
      end,
      desc = "Notification commands",
      mode = "n",
    },
    {
      "<leader>H[",
      function()
        require("which-key").show({ keys = "[", loop = true })
      end,
      desc = "Prev nav (diagnostics, errors, buffers, todos…)",
      mode = "n",
    },
    {
      "<leader>H]",
      function()
        require("which-key").show({ keys = "]", loop = true })
      end,
      desc = "Next nav (diagnostics, errors, buffers, todos…)",
      mode = "n",
    },
    {
      "<leader>Hg",
      function()
        require("which-key").show({ keys = "g", loop = true })
      end,
      desc = "g-prefix (LSP, comments, URI, scope…)",
      mode = "n",
    },
  },
}
