-- plugins/tools/minimap.lua
return {
  "wfxr/minimap.vim",
  lazy = false,
  build = "cargo install --locked code-minimap",
  config = function()
    -- Minimap settings
    vim.g.minimap_width = 10
    vim.g.minimap_auto_start = 1
    vim.g.minimap_auto_start_win_enter = 1
    vim.g.minimap_highlight_range = 1
    vim.g.minimap_highlight_search = 1
    vim.g.minimap_git_colors = 1
    vim.g.minimap_left = 0  -- Ensure minimap opens on the RIGHT side (0 = right, 1 = left)
    vim.g.minimap_window_style = 'minimal'

    -- Toggle mapping
    vim.keymap.set("n", "<leader>mm", "<cmd>MinimapToggle<CR>", { desc = "Toggle Minimap" })

    -- Close and reopen minimap to fix positioning (with safety check)
    vim.defer_fn(function()
      -- Check if command exists before running
      if vim.fn.exists(':MinimapClose') > 0 then
        pcall(vim.cmd, "MinimapClose")
      end
      if vim.fn.exists(':MinimapOpen') > 0 then
        pcall(vim.cmd, "MinimapOpen")
      end
    end, 500)  -- Increased delay to 500ms to ensure plugin is loaded
  end,
}