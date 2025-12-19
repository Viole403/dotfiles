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
        "ts_ls",
        "html",
        "cssls",
        "jsonls",
      },
    })

    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local servers = {
      "lua_ls",
      "pyright",
      "gopls",
      "ts_ls",
      "html",
      "cssls",
      "jsonls",
    }

    for _, server in ipairs(servers) do
      lspconfig[server].setup({
        capabilities = capabilities,
      })
    end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition)
    vim.keymap.set("n", "gr", vim.lsp.buf.references)
    vim.keymap.set("n", "K", vim.lsp.buf.hover)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
  end,
}
