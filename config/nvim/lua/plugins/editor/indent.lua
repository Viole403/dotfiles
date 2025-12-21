-- plugins/editor/indent.lua
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
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

    vim.g.rainbow_delimiters = { highlight = highlight }

    -- Setup indent-blankline with rainbow colors cycling through levels
    require("ibl").setup({
      indent = {
        char = "│",
        tab_char = "│",
        highlight = highlight,  -- This cycles colors through indent levels
      },
      scope = {
        enabled = false,  -- Disable scope to see all indent colors clearly
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

    -- Make sure colors cycle through indent levels
    hooks.register(
      hooks.type.WHITESPACE,
      hooks.builtin.hide_first_space_indent_level
    )
  end,
}