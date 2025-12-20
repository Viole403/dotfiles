-- config/nvim/lua/plugins/lsp/python.lua
local lsp = require("lspconfig")
local c = require("plugins.lsp.common")

lsp.pyright.setup({
  capabilities = c.capabilities,
  on_attach = c.on_attach,
})
