-- plugins/coding/languages/deno.lua
return {
  "neovim/nvim-lspconfig",
  ft = { "typescript", "typescriptreact" },
  config = function()
    local lspconfig = require("lspconfig")
    local lsp = require("plugins.coding.lsp")
    local util = require("lspconfig.util")

    -- Only activate in Deno projects (deno.json present)
    lspconfig.denols.setup({
      capabilities = lsp.common.get_capabilities(),
      on_attach = lsp.common.on_attach,
      root_dir = util.root_pattern("deno.json", "deno.jsonc"),
    })
  end,
}
