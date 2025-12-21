-- plugins/coding/languages/lua.lua
return {
  "neovim/nvim-lspconfig",
  ft = "lua",
  config = function()
    local lspconfig = require("lspconfig")
    local lsp = require("plugins.coding.lsp")

    lspconfig.lua_ls.setup({
      capabilities = lsp.common.get_capabilities(),
      on_attach = lsp.common.on_attach,
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
  end,
}
