-- ~/.config/nvim/lua/plugins/avante.lua
-- avante.nvim — Gemini provider (updated API, May 2026)
-- Migration: provider config now lives under opts.providers.<name>
-- Request body fields (temperature, max_tokens) go inside extra_request_body

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never pin to "*" — always track main
  build = vim.fn.has("win32") ~= 0
    and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make",

  ---@module 'avante'
  ---@type avante.Config
  opts = {
    -- ────────────────────────────────────────────────────────────
    -- Provider selection
    -- ────────────────────────────────────────────────────────────
    provider = "gemini",

    -- ────────────────────────────────────────────────────────────
    -- Provider definitions  (NEW structure — all under `providers`)
    -- Old top-level `gemini = { ... }` is DEPRECATED
    -- ────────────────────────────────────────────────────────────
    providers = {
      gemini = {
        -- API key is read from the environment variable.
        -- Avante supports a scoped prefix: AVANTE_GEMINI_API_KEY takes
        -- priority over GEMINI_API_KEY, keeping the key isolated to Avante.
        -- Both are exported from ~/.zshrc via secret-tool (see Seahorse guide).
        api_key_name = "GEMINI_API_KEY",   -- or "AVANTE_GEMINI_API_KEY"

        model   = "gemini-2.0-flash",      -- fast & cheap; swap to gemini-2.5-pro for harder tasks
        timeout = 30000,                   -- ms; increase for slow connections

        -- ⚠️  Request body fields MUST live inside extra_request_body
        extra_request_body = {
          temperature = 0.75,
          max_tokens  = 1024,
        },
      },
    },

    -- ────────────────────────────────────────────────────────────
    -- Interaction mode
    -- ────────────────────────────────────────────────────────────
    mode = "agentic", -- "agentic" (default) | "legacy"

    -- ────────────────────────────────────────────────────────────
    -- Behaviour
    -- ────────────────────────────────────────────────────────────
    behaviour = {
      auto_suggestions                  = false,
      auto_set_highlight_group          = true,
      auto_set_keymaps                  = true,
      auto_apply_diff_after_generation  = false,
      support_paste_from_clipboard      = false,
      minimize_diff                     = true,
      enable_token_counting             = true,
      auto_add_current_file             = true,
      auto_approve_tool_permissions     = true,
    },

    -- ────────────────────────────────────────────────────────────
    -- Sidebar window
    -- ────────────────────────────────────────────────────────────
    windows = {
      position = "right",
      wrap     = true,
      width    = 30,
      sidebar_header = {
        enabled = true,
        align   = "center",
        rounded = true,
      },
      input = {
        prefix = "> ",
        height = 8,
      },
      edit = {
        border       = "rounded",
        start_insert = true,
      },
      ask = {
        floating       = false,
        start_insert   = true,
        border         = "rounded",
        focus_on_apply = "ours",
      },
    },

    -- ────────────────────────────────────────────────────────────
    -- Diff / conflict resolution
    -- ────────────────────────────────────────────────────────────
    diff = {
      autojump            = true,
      list_opener         = "copen",
      override_timeoutlen = 500,
    },
  },

  -- ──────────────────────────────────────────────────────────────
  -- Dependencies
  -- ──────────────────────────────────────────────────────────────
  dependencies = {
    -- Required
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter",

    -- UI — pick ONE input provider (dressing or snacks)
    "stevearc/dressing.nvim",            -- enhanced input popups
    -- "folke/snacks.nvim",              -- alternative modern input UI

    -- Icons
    "nvim-tree/nvim-web-devicons",       -- or "echasnovski/mini.icons"

    -- File selector — pick ONE (telescope, fzf-lua, mini.pick, or snacks)
    "nvim-telescope/telescope.nvim",
    -- "ibhagwan/fzf-lua",
    -- "nvim-mini/mini.pick",

    -- Autocompletion for avante slash-commands and @mentions
    "hrsh7th/nvim-cmp",                  -- or configure blink.cmp — see plugin-avante.md

    -- Image paste support (optional but recommended)
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name  = false,
          drag_and_drop         = { insert_mode = true },
          use_absolute_path     = true,
        },
      },
    },

    -- Markdown rendering inside avante panels (optional but recommended)
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
