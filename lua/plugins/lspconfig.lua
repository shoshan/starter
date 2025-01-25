local lsp = vim.g.lazyvim_python_lsp or "pyright"
local ruff = vim.g.lazyvim_python_ruff or "ruff"

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts = opts or {}
      local cpu_model = vim.fn.getenv("CPU_MODEL") or ""
      local servers = { "pyright", "ruff" }
      local servers_mason_install = cpu_model == "Raspberry Pi" and { "ruff" } or { "pyright", "ruff" }
      for _, server in ipairs(servers) do
        opts.servers[server] = opts.servers[server] or {}
        if vim.tbl_contains(servers_mason_install, server) then
          opts.servers[server].mason = true
        else
          opts.servers[server].mason = false
        end
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts = opts or {}
      opts.setup = opts.setup or {}
      -- Setup on_attach for the `ruff` LSP server
      opts.setup[ruff] = function()
        LazyVim.lsp.on_attach(function(client, _)
          -- Disable hover in favor of Pyright
          client.server_capabilities.hoverProvider = false
        end) -- Close the function here without passing `ruff`
      end
    end,
  },
}
