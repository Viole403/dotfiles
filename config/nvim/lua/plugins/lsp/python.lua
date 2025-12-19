local lsp = require("lspconfig")
local c = require("lsp.common")

lsp.pyright.setup({
  capabilities = c.capabilities,
  on_attach = c.on_attach,
})
