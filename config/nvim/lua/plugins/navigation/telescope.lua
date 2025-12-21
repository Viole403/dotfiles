-- plugins/navigation/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("telescope").setup({
      defaults = {
        prompt_prefix = "> ",
        selection_caret = "> ",
        sorting_strategy = "ascending",
        path_display = { "smart" },
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
        },
      },
    })

    local map = vim.keymap.set
    map("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
    map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
    map("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
    map("n", "<leader>pd", "<cmd>Telescope projects<CR>")
    map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
  end,
}
