-- plugins/tmux.lua
return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  config = function()
    -- Disable default mappings
    vim.g.tmux_navigator_no_mappings = 1

    -- Custom keymaps for tmux navigation
    vim.api.nvim_set_keymap("n", "<C-h>", ":TmuxNavigateLeft<CR>", { silent = true })
    vim.api.nvim_set_keymap("n", "<C-j>", ":TmuxNavigateDown<CR>", { silent = true })
    vim.api.nvim_set_keymap("n", "<C-k>", ":TmuxNavigateUp<CR>", { silent = true })
    vim.api.nvim_set_keymap("n", "<C-l>", ":TmuxNavigateRight<CR>", { silent = true })
  end
}
