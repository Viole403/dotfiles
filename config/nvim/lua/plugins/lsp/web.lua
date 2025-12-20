-- config/nvim/lua/plugins/lsp/web.lua
local lsp = require("lspconfig")
local c = require("plugins.lsp.common")

for _, server in ipairs({ "html", "cssls", "jsonls", "astro" }) do
  lsp[server].setup({
    capabilities = c.capabilities,
    on_attach = c.on_attach,
  })
end
