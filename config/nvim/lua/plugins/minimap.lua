return {
  "wfxr/minimap.vim",
  lazy = false,
  build = "cargo install --locked code-minimap", -- Optional: auto-install if cargo is available
  config = function()
    -- Minimap settings
    vim.g.minimap_width = 10
    vim.g.minimap_auto_start = 1
    vim.g.minimap_auto_start_win_enter = 1
    vim.g.minimap_highlight_range = 1
    vim.g.minimap_highlight_search = 1
    vim.g.minimap_git_colors = 1

    -- Toggle mapping
    vim.keymap.set("n", "<leader>mm", "<cmd>MinimapToggle<CR>", { desc = "Toggle Minimap" })
  end,
}