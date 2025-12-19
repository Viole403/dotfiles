-- plugins/minimap.lua
return {
  "wfxr/minimap.vim",
  cmd = { "Minimap", "MinimapToggle", "MinimapClose" },
  dependencies = "nvim-lua/plenary.nvim",
  lazy = false,
  config = function()
    -- Disable auto_start in the plugin itself
    vim.g.minimap_auto_start = 0
    vim.g.minimap_width = 10
    vim.g.minimap_highlight_search = 1
    vim.g.minimap_git_colors = 1
    vim.g.minimap_block_filetypes = { "NvimTree", "TelescopePrompt", "alpha", "dashboard" }

    -- Auto start after VimEnter and bufferline is ready
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        -- Delay a tiny bit to ensure bufferline loaded
        vim.defer_fn(function()
          vim.cmd("Minimap")
        end, 100)
      end
    })
  end,
}
