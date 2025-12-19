local lsp = require("lspconfig")
local c = require("plugins.lsp.common")

lsp.intelephense.setup({
  capabilities = c.capabilities,
  on_attach = c.on_attach,
})
