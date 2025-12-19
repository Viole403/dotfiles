-- plugins/bufferline.lua
return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  lazy = false,
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers",

        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false,

        separator_style = "thin",
        always_show_bufferline = true,

        custom_filter = function(bufnr)
          local ft = vim.bo[bufnr].filetype
          if ft == "minimap" then
            return false
          end
          return true
        end,

        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },

        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count)
          return " " .. count
        end,
      },
    })

    -- Keybindings
    vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
    vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
    vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
    vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer" })
  end,
}
