-- plugins/indent.lua
return {
  "TheGLander/indent-rainbowline.nvim",
  dependencies = {
    "lukas-reineke/indent-blankline.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }

    local hooks = require("ibl.hooks")

    -- Create the highlight groups with Catppuccin Frappe colors
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E78284" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C890" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#8CAAEE" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#EF9F76" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#A6D189" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#CA9EE6" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#81C8BE" })
    end)

    -- Setup indent-blankline with rainbow colors
    require("ibl").setup({
      indent = {
        char = "│",
        highlight = highlight,
      },
      whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
        highlight = highlight,
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
          "NvimTree",
          "minimap",
        },
      },
    })

    -- Setup indent-rainbowline
    require("indent-rainbowline").make_scope_hl_from_rainbow(highlight)
  end,
}