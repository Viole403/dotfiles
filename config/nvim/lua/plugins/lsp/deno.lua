-- config/nvim/lua/plugins/lsp/deno.lua
local lsp = require("lspconfig")
local c = require("plugins.lsp.common")
local util = require("lspconfig.util")

lsp.denols.setup({
  capabilities = c.capabilities,
  on_attach = c.on_attach,
  root_dir = util.root_pattern("deno.json", "deno.jsonc"),
})
