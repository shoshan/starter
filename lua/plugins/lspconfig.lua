return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local servers = { "pyright",  "ruff" }
    for _, server in ipairs(servers) do
      opts.servers[server] = opts.servers[server] or {}
      opts.servers[server].mason = false
    end
  end,
}
