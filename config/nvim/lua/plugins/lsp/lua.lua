local lsp = require("lspconfig")
local c = require("plugins.lsp.common")

lsp.lua_ls.setup({
  capabilities = c.capabilities,
  on_attach = c.on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
