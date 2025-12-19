-- Minimap plugin configuration
return {
  'wfxr/minimap.vim',
  build = "cargo install --locked code-minimap",
  cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
  lazy = false,
  init = function()
    vim.cmd("let g:minimap_width = 10")
    vim.cmd("let g:minimap_auto_start = 1")
    vim.cmd("let g:minimap_auto_start_win_enter = 1")
    vim.cmd("let g:minimap_window_side = 'right'")
    vim.g.minimap_block_filetypes = { "NvimTree", "TelescopePrompt", "alpha", "dashboard" }
  end,
}