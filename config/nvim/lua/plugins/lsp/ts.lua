local lsp = require("lspconfig")
local c = require("lsp.common")
local util = require("lspconfig.util")

lsp.ts_ls.setup({
  capabilities = c.capabilities,
  on_attach = c.on_attach,
  root_dir = util.root_pattern("package.json"),
  single_file_support = false,
})
