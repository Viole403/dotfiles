-- plugins/editor/todo-comments.lua
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("todo-comments").setup({
      signs = false,  -- No gutter signs
      keywords = {
        FIX = {
          icon = "!",
          color = "error",
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
        },
        TODO = {
          icon = "*",
          color = "info",
        },
        HACK = {
          icon = "?",
          color = "warning",
        },
        WARN = {
          icon = "~",
          color = "warning",
          alt = { "WARNING", "XXX" },
        },
        PERF = {
          icon = "+",
          alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
        },
        NOTE = {
          icon = "-",
          color = "hint",
          alt = { "INFO" },
        },
        TEST = {
          icon = "T",
          color = "test",
          alt = { "TESTING", "PASSED", "FAILED" },
        },
      },
      highlight = {
        multiline = true,
        before = "",
        keyword = "wide_bg",  -- Colorful background
        after = "fg",
      },
      colors = {
        error = { "#E78284" },     -- Catppuccin Frappe red
        warning = { "#EF9F76" },   -- Catppuccin Frappe orange
        info = { "#8CAAEE" },      -- Catppuccin Frappe blue
        hint = { "#A6D189" },      -- Catppuccin Frappe green
        default = { "#CA9EE6" },   -- Catppuccin Frappe violet
        test = { "#F4B8E4" },      -- Catppuccin Frappe pink
      },
    })

    vim.keymap.set("n", "]t", function()
      require("todo-comments").jump_next()
    end, { desc = "Next todo" })

    vim.keymap.set("n", "[t", function()
      require("todo-comments").jump_prev()
    end, { desc = "Previous todo" })

    vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
  end,
}