-- config/nvim/lua/plugins/lsp/common.lua
local M = {}

M.capabilities =
  require("cmp_nvim_lsp").default_capabilities()

function M.on_attach(_, bufnr)
  local map = function(m, k, v)
    vim.keymap.set(m, k, v, { buffer = bufnr })
  end

  map("n", "gd", vim.lsp.buf.definition)
  map("n", "gr", vim.lsp.buf.references)
  map("n", "K", vim.lsp.buf.hover)
  map("n", "<leader>rn", vim.lsp.buf.rename)
  map("n", "<leader>ca", vim.lsp.buf.code_action)
end

return M
