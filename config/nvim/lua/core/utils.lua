-- core/utils.lua
-- Helper functions for deprecated vim.lsp.util functions

local M = {}

-- Modern replacement for vim.lsp.util.make_position_params
function M.make_position_params(bufnr)
  bufnr = bufnr or 0
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  return {
    textDocument = vim.lsp.util.make_text_document_params(bufnr),
    position = {
      line = row - 1,
      character = col,
    },
  }
end

-- Helper for reverse lookup (replaces vim.tbl_add_reverse_lookup)
function M.add_reverse_lookup(t)
  for k, v in pairs(t) do
    t[v] = k
  end
  return t
end

-- Helper to flatten tables (replaces vim.tbl_flatten)
function M.tbl_flatten(t)
  local result = {}
  for _, v in ipairs(t) do
    if type(v) == "table" then
      vim.list_extend(result, M.tbl_flatten(v))
    else
      table.insert(result, v)
    end
  end
  return result
end

-- Set global helpers
vim.lsp.util.make_position_params = M.make_position_params

return M
