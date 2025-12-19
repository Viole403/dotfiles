local lsp = require("lspconfig")
local c = require("lsp.common")

lsp.intelephense.setup({
  capabilities = c.capabilities,
  on_attach = c.on_attach,
})
