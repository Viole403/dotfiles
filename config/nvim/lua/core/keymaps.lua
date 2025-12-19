-- core/keymaps.lua
vim.keymap.set("v", "<C-S-c>", '"+y')
vim.keymap.set({ "n", "i" }, "<C-S-v>", '"+p')
vim.keymap.set("i", "<C-S-v>", "<C-r>+")

-- NvimTree toggle
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

vim.g.tmux_navigator_no_mappings = 1
vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>")
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>")
vim.keymap.set("n", "<C-\\>", "<Cmd>TmuxNavigateLastActive<CR>")