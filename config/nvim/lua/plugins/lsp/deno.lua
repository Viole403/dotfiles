local lsp = require("lspconfig")
local c = require("lsp.common")
local util = require("lspconfig.util")

lsp.denols.setup({
  capabilities = c.capabilities,
  on_attach = c.on_attach,
  root_dir = util.root_pattern("deno.json", "deno.jsonc"),
})
