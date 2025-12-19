-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader keys before lazy
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim with all plugins
require("lazy").setup({
  require("plugins.lualine"),
  require("plugins.bufferline"),
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
  require("plugins.minimap"),
  require("plugins.none-ls"),

  { "christoomey/vim-tmux-navigator", lazy = false },
  { "wakatime/vim-wakatime", lazy = false },
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    config = function()
      local ok, project = pcall(require, "project_nvim")
      if ok then
        project.setup({})
        pcall(require("telescope").load_extension, "projects")
      end
    end
  },
  { "RRethy/vim-illuminate", enabled = false },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "frappe",
        background = {
          light = "latte",
          dark = "frappe",
        },
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          treesitter = true,
          telescope = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}, {
  -- Disable luarocks support to avoid build issues
  rocks = {
    enabled = false,
  },
})
