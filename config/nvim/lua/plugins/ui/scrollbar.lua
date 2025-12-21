-- plugins/ui/scrollbar.lua
return {
  "petertriho/nvim-scrollbar",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "lewis6991/gitsigns.nvim",  -- Add gitsigns as dependency
  },
  config = function()
    require("scrollbar").setup({
      show = true,
      show_in_active_only = false,
      set_highlights = true,
      handle = {
        text = " ",
        color = "#5a5a5a",
        hide_if_all_visible = true,
      },
      marks = {
        Cursor = {
          text = "•",
          priority = 0,
          color = "#8CAAEE",
        },
        Search = {
          text = { "-", "=" },
          priority = 1,
          color = "#E5C890",
        },
        Error = {
          text = { "-", "=" },
          priority = 2,
          color = "#E78284",
        },
        Warn = {
          text = { "-", "=" },
          priority = 3,
          color = "#EF9F76",
        },
        Info = {
          text = { "-", "=" },
          priority = 4,
          color = "#81C8BE",
        },
        Hint = {
          text = { "-", "=" },
          priority = 5,
          color = "#A6D189",
        },
        Misc = {
          text = { "-", "=" },
          priority = 6,
          color = "#CA9EE6",
        },
        GitAdd = {
          text = "│",
          priority = 7,
          color = "#A6D189",
        },
        GitChange = {
          text = "│",
          priority = 7,
          color = "#E5C890",
        },
        GitDelete = {
          text = "▁",
          priority = 7,
          color = "#E78284",
        },
      },
      excluded_buftypes = {
        "terminal",
      },
      excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
        "noice",
        "alpha",
        "dashboard",
        "NvimTree",
        "lazy",
        "mason",
        "minimap",
      },
      handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = true,
        handle = true,
        search = false,
      },
    })

    -- Integrate with gitsigns after both plugins are loaded
    pcall(function()
      require("scrollbar.handlers.gitsigns").setup()
    end)
  end,
}