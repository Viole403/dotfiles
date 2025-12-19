-- Minimap plugin configuration
return {
  "wfxr/minimap.vim",
  build = "cargo install --locked code-minimap",
  cmd = { "Minimap", "MinimapToggle" },
  config = function()
    vim.g.minimap_width = 10
    vim.g.minimap_auto_start = 0
    vim.g.minimap_highlight_search = 1
    vim.g.minimap_git_colors = 1
    vim.g.minimap_block_filetypes = { "NvimTree", "TelescopePrompt", "alpha", "dashboard" }
  end,
}