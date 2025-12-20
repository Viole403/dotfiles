-- plugins/lsp.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "pyright",
        "gopls",
        "rust_analyzer",
        "intelephense",
        "ts_ls",
        "denols",
        "astro",
        "html",
        "cssls",
        "jsonls",
      },
    })

    require("plugins.lsp")
  end,
}
