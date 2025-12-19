local lsp = require("lspconfig")
local c = require("plugins.lsp.common")

lsp.gopls.setup({
  capabilities = c.capabilities,
  on_attach = c.on_attach,
  settings = {
    gopls = {
      staticcheck = true,
      analyses = { unusedparams = true },
    },
  },
})
