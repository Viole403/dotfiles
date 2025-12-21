-- plugins/coding/languages/typescript.lua
return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  config = function()
    local lsp = require("plugins.coding.lsp")
    local util = require("lspconfig.util")

    -- typescript-tools replaces ts_ls, no need for lsp/ts.lua
    require("typescript-tools").setup({
      capabilities = lsp.common.capabilities,
      on_attach = lsp.common.on_attach,
      root_dir = util.root_pattern("package.json"),
      single_file_support = false,
      settings = {
        separate_diagnostic_server = true,
        publish_diagnostic_on = "insert_leave",
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    })

    -- Format on save with prettierd (handled by none-ls globally)
  end,
}
