-- plugins/tools/minimap.lua
return {
  "wfxr/minimap.vim",
  lazy = false,
  build = "cargo install --locked code-minimap",
  config = function()
    -- Minimap settings
    vim.g.minimap_width = 10
    vim.g.minimap_auto_start = 0  -- Disable auto start to prevent positioning issues
    vim.g.minimap_auto_start_win_enter = 0
    vim.g.minimap_highlight_range = 1
    vim.g.minimap_highlight_search = 1
    vim.g.minimap_git_colors = 1
    vim.g.minimap_left = 0  -- Open on RIGHT side (0 = right, 1 = left)
    vim.g.minimap_window_style = 'minimal'

    -- Set window position to far right (after scrollbar)
    vim.g.minimap_window_position = 'right'

    -- Toggle mapping
    vim.keymap.set("n", "<leader>mm", "<cmd>MinimapToggle<CR>", { desc = "Toggle Minimap" })
  end,
}