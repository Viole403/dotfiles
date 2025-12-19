local lsp = require("lspconfig")
local c = require("lsp.common")

lsp.rust_analyzer.setup({
  capabilities = c.capabilities,
  on_attach = c.on_attach,
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      checkOnSave = { command = "clippy" },
    },
  },
})
