-- plugins/scrollbar.lua
return {
  "petertriho/nvim-scrollbar",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
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
          gui = nil,
          color = "#8CAAEE", -- Catppuccin Frappe blue
          cterm = nil,
          highlight = "Normal",
        },
        Search = {
          text = { "-", "=" },
          priority = 1,
          gui = nil,
          color = "#E5C890", -- Catppuccin Frappe yellow
          cterm = nil,
          highlight = "Search",
        },
        Error = {
          text = { "-", "=" },
          priority = 2,
          gui = nil,
          color = "#E78284", -- Catppuccin Frappe red
          cterm = nil,
          highlight = "DiagnosticVirtualTextError",
        },
        Warn = {
          text = { "-", "=" },
          priority = 3,
          gui = nil,
          color = "#EF9F76", -- Catppuccin Frappe orange
          cterm = nil,
          highlight = "DiagnosticVirtualTextWarn",
        },
        Info = {
          text = { "-", "=" },
          priority = 4,
          gui = nil,
          color = "#81C8BE", -- Catppuccin Frappe cyan
          cterm = nil,
          highlight = "DiagnosticVirtualTextInfo",
        },
        Hint = {
          text = { "-", "=" },
          priority = 5,
          gui = nil,
          color = "#A6D189", -- Catppuccin Frappe green
          cterm = nil,
          highlight = "DiagnosticVirtualTextHint",
        },
        Misc = {
          text = { "-", "=" },
          priority = 6,
          gui = nil,
          color = "#CA9EE6", -- Catppuccin Frappe violet
          cterm = nil,
          highlight = "Normal",
        },
        GitAdd = {
          text = "│",
          priority = 7,
          gui = nil,
          color = "#A6D189",
          cterm = nil,
          highlight = "GitSignsAdd",
        },
        GitChange = {
          text = "│",
          priority = 7,
          gui = nil,
          color = "#E5C890",
          cterm = nil,
          highlight = "GitSignsChange",
        },
        GitDelete = {
          text = "▁",
          priority = 7,
          gui = nil,
          color = "#E78284",
          cterm = nil,
          highlight = "GitSignsDelete",
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
      autocmd = {
        render = {
          "BufWinEnter",
          "TabEnter",
          "TermEnter",
          "WinEnter",
          "CmdwinLeave",
          "TextChanged",
          "VimResized",
          "WinScrolled",
        },
        clear = {
          "BufWinLeave",
          "TabLeave",
          "TermLeave",
          "WinLeave",
        },
      },
      handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = true,
        handle = true,
        search = false, -- Requires hlslens
      },
    })
  end,
}