require("lazy").setup({
  require("plugins.lualine"),
  require("plugins.nvimtree"),
  require("plugins.treesitter"),
  require("plugins.alpha"),
  require("plugins.terminal"),
  require("plugins.rest"),
  require("plugins.dadbod"),
  require("plugins.cmp"),
  require("plugins.lsp"),
  require("plugins.scala"),
  require("plugins.rainbow"),
  require("plugins.telescope"),

  "christoomey/vim-tmux-navigator",
  "wakatime/vim-wakatime",

  {
    "wfxr/minimap.vim",
    build = "cargo install --locked code-minimap",
    init = function()
      vim.g.minimap_width = 10
      vim.g.minimap_auto_start = 1
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "frappe",
        show_end_of_buffer = false,
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
})
