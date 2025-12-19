-- Minimap plugin configuration
return {
  "wfxr/minimap.vim",
  build = "cargo install --locked code-minimap",
  cmd = { "Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight" },
  lazy = false,
  config = function()
    vim.g.minimap_width = 10
    vim.g.minimap_auto_start = 1
    vim.g.minimap_auto_start_win_enter = 1
    vim.g.minimap_highlight_search = 1
    vim.g.minimap_git_colors = 1
    vim.g.minimap_block_filetypes = { "NvimTree", "TelescopePrompt", "alpha", "dashboard" }
  end,
}