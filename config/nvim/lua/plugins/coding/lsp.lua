-- plugins/coding/lsp.lua
-- Main LSP infrastructure (Mason for server installation)
-- Individual language LSP configs are in plugins/coding/languages/
-- This file also exports shared LSP utilities (capabilities, on_attach)

local M = {}

-- Shared LSP utilities (used by language configs)
M.common = {}

-- Lazy-load capabilities to avoid loading cmp_nvim_lsp before it's installed
function M.common.get_capabilities()
  return require("cmp_nvim_lsp").default_capabilities()
end

function M.common.on_attach(_, bufnr)
  local map = function(m, k, v)
    vim.keymap.set(m, k, v, { buffer = bufnr })
  end

  map("n", "gd", vim.lsp.buf.definition)
  map("n", "gr", vim.lsp.buf.references)
  map("n", "K", vim.lsp.buf.hover)
  map("n", "<leader>rn", vim.lsp.buf.rename)
  map("n", "<leader>ca", vim.lsp.buf.code_action)
end

-- Plugin specification
M[1] = "neovim/nvim-lspconfig"
M.dependencies = {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "hrsh7th/cmp-nvim-lsp",
}
M.config = function()
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

  -- Language-specific LSP configs are loaded via their individual plugin files
  -- See: plugins/coding/languages/*.lua
end

return M
