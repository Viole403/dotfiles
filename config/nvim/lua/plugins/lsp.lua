return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local ok_mason, mason = pcall(require, "mason")
    if not ok_mason then return end
    mason.setup()

    local ok_mason_lsp, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not ok_mason_lsp then return end
    mason_lspconfig.setup({
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

    local ok_lsp, lspconfig = pcall(require, "lspconfig")
    if not ok_lsp then return end

    local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = ok_cmp and cmp_nvim_lsp.default_capabilities() or {}

    local servers = {
      "lua_ls",
      "pyright",
      "gopls",
      "ts_ls",
      "html",
      "cssls",
      "jsonls",
    }

    -- Temporarily disable deprecation warnings
    local deprecate = vim.deprecate
    vim.deprecate = function() end

    for _, server in ipairs(servers) do
      lspconfig[server].setup({
        capabilities = capabilities,
      })
    end

    -- Restore deprecate function
    vim.deprecate = deprecate

    vim.keymap.set("n", "gd", vim.lsp.buf.definition)
    vim.keymap.set("n", "gr", vim.lsp.buf.references)
    vim.keymap.set("n", "K", vim.lsp.buf.hover)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
  end,
}
