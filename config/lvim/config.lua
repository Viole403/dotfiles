-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- Lunarvim configuration

-- Setup copy paste
vim.g.clipboard = {
  name = "osc52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}

-- COPY
vim.keymap.set({ "v" }, "<C-S-c>", '"+y')

-- PASTE
vim.keymap.set({ "n", "i" }, "<C-S-v>", '"+p')
vim.keymap.set("i", "<C-S-v>", "<C-r>+")

-- setup without icons
vim.g.have_nerd_font = false
lvim.use_icons = false

lvim.builtin.nvimtree.setup.renderer = {
  icons = {
    show = {
      file = false,
      folder = false,
      folder_arrow = false,
      git = false,
      modified = false,
      diagnostics = false,
    },
    glyphs = {
      default = "",
      symlink = "",
      folder = {
        arrow_closed = "",
        arrow_open = "",
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
        symlink_open = "",
      },
      git = {
        unstaged = "",
        staged = "",
        unmerged = "",
        renamed = "",
        untracked = "",
        deleted = "",
        ignored = "",
      },
    },
  },
}

lvim.builtin.nvimtree.setup.renderer.icons.show = {
  file = false,
  folder = false,
  folder_arrow = false,
  git = false
}

vim.diagnostic.config({
  signs = false,
})

-- Setup lualine
lvim.builtin.lualine.active = true
lvim.builtin.lualine.options = {
  icons_enabled = false,
  theme = "auto",
  component_separators = "",
  section_separators = "",
  always_divide_middle = true,
}

lvim.builtin.lualine.options.icons_enabled = false
lvim.builtin.bufferline.options.show_buffer_icons = false
lvim.builtin.bufferline.options.show_buffer_close_icons = false
lvim.builtin.bufferline.options.show_close_icon = false

lvim.builtin.lualine.sections = {
  lualine_a = { "mode" },
  lualine_b = { "branch" },
  lualine_c = { "filename" },
  lualine_x = { "encoding", "fileformat", "filetype" },
  lualine_y = { "progress" },
  lualine_z = { "location" },
}

lvim.builtin.lualine.inactive_sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = { "filename" },
  lualine_x = { "location" },
  lualine_y = {},
  lualine_z = {},
}

-- Colorscheme lunarvim
lvim.colorscheme = "catppuccin"
lvim.builtin.lualine.options.theme = "catppuccin"

-- Disable Illmuate
lvim.builtin.illuminate.active = false

-- Rainbow Parentheses
lvim.builtin.treesitter.rainbow = {
  enable = true,
  extended_mode = true,
  max_file_lines = nil,
}

-- Setup terminal pane direction
lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = "horizontal"
lvim.builtin.terminal.size = 10
lvim.builtin.terminal.open_mapping = "<C-\\>"

vim.g.tmux_navigator_no_mappings = 1
vim.api.nvim_set_keymap("n", "<C-h>", ":TmuxNavigateLeft<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<C-j>", ":TmuxNavigateDown<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<C-k>", ":TmuxNavigateUp<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<C-l>", ":TmuxNavigateRight<CR>", {silent = true})

-- Custom alpha dashboard tanpa ikon
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

local alpha = require "alpha"
local dashboard = require "alpha.themes.dashboard"

-- Judul tanpa ikon
dashboard.section.header.val = {
  "LunarVim"
}

-- Menu sederhana tanpa ikon
dashboard.section.buttons.val = {
  dashboard.button("f", "Find File", ":Telescope find_files<CR>"),
  dashboard.button("n", "New File", ":ene <BAR> startinsert<CR>"),
  dashboard.button("p", "Projects", ":Telescope projects<CR>"),
  dashboard.button("r", "Recent files", ":Telescope oldfiles<CR>"),
  dashboard.button("t", "Find Text", ":Telescope live_grep<CR>"),
  dashboard.button("c", "Configuration", ":e ~/.config/lvim/config.lua<CR>"),
  dashboard.button("q", "Quit", ":qa<CR>")
}
alpha.setup(dashboard.config)

-- Enable Telescope
lvim.builtin.telescope.active = true

-- Telescope config
lvim.builtin.telescope.defaults = {
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
}

-- Keymaps
lvim.keys.normal_mode["<leader>ff"] = "<cmd>Telescope find_files<CR>"
lvim.keys.normal_mode["<leader>fg"] = "<cmd>Telescope live_grep<CR>"
lvim.keys.normal_mode["<leader>fb"] = "<cmd>Telescope buffers<CR>"
lvim.keys.normal_mode["<leader>fh"] = "<cmd>Telescope help_tags<CR>"
lvim.keys.normal_mode["<leader>pd"] = "<cmd>Telescope projects<CR>"

-- Intellisense tree-sitter parsers (synchronized with nvim config)
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "lua",
  "python",
  "go",
  "java",
  "php",
  "rust",
  "html",
  "css",
  "json",
  "javascript",
  "typescript",
  "tsx",
  "yaml",
  "markdown",
  -- Additional parsers for LunarVim-specific use
  "scala",
  "org",
  "c",
  "ruby",
  "http",
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "prettierd", filetypes = { "html", "vue", "css", "scss", "typescriptreact", "typescript", "php" } },
  { command = "scalafmt", args = { "--stdin" }, filetypes = { "scala", "sbt" } }
}

-- Databases
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.sql", "*.mysql", "*.pssql" },
--   command = "lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })",
-- })

-- LSP Configuration (synchronized with nvim config)
-- Core LSP servers: lua_ls, pyright, gopls, ts_ls, html, cssls, jsonls
-- These are automatically configured by LunarVim's LSP manager
-- Additional tools configured via Mason: biome, deno, editorconfig-checker, goimport, gofumpt, golines, mdformat

-- Tailwind
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tailwindcss" })
require("lvim.lsp.manager").setup("tailwindcss", {
  filetypes = { "typescriptreact" }
})

-- Scala
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.scala", "*.sbt" },
  command = "lua require('user.metals').config()"
})

-- Modern replacement for vim.lsp.util.make_position_params
vim.lsp.util.make_position_params = function(bufnr)
bufnr = bufnr or 0
local row, col = unpack(vim.api.nvim_win_get_cursor(0))
return {
  textDocument = vim.lsp.util.make_text_document_params(bufnr),
  position = {
    line = row - 1,
    character = col,
  },
}
end

-- Helper for reverse lookup (replaces vim.tbl_add_reverse_lookup)
local function add_reverse_lookup(t)
for k, v in pairs(t) do
  t[v] = k
end
  return t
end

-- Helper to flatten tables (replaces vim.tbl_flatten)

local function tbl_flatten(t)
local result = {}
for _, v in ipairs(t) do
  if type(v) == "table" then
    vim.list_extend(result, tbl_flatten(v))
  else
    table.insert(result, v)
  end
end
  return result
end

-- Plugin NeoVim
lvim.plugins = {
  -- Go
  -- "olexsmir/gopher.nvim",
  -- "leoluz/nvim-dap-go",

  -- Python
  -- "ChristianChiarulli/swenv.nvim",
  -- "stevearc/dressing.nvim",
  -- "mfussenegger/nvim-dap-python",

  -- Testing
  -- "nvim-neotest/neotest",
  -- "nvim-neotest/neotest-python",
  -- "nvim-neotest/nvim-nio",

  -- Utility
  -- "windwp/nvim-ts-autotag",
  "wakatime/vim-wakatime",

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
          lsp_trouble = true,
          which_key = true,
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
    end,
  }, {
    'wfxr/minimap.vim',
    build = "cargo install --locked code-minimap",
    cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
    lazy = false,
    init = function()
      vim.cmd("let g:minimap_width = 10")
      vim.cmd("let g:minimap_auto_start = 1")
      vim.cmd("let g:minimap_auto_start_win_enter = 1")
    end,
  }, {
    "christoomey/vim-tmux-navigator",
    lazy = false, -- langsung load
  }, {
    "rest-nvim/rest.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("rest-nvim").setup({
        result_split_horizontal = false,
        result_split_in_place = false,
        skip_ssl_verification = false,
        encode_url = true,
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          show_url = true,
          show_http_info = true,
          show_headers = true,
          formatters = {
            json = "jq",
            html = function(body)
              return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
            end
          },
        },
        jump_to_request = false,
        env_file = '.env',
        custom_dynamic_variables = {},
        yank_dry_run = true,
      })
    end,
  }, {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true,
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    -- Use the 'config' key to set up the plugin
    config = function()
      -- Setup vim-dadbod-ui without Nerd Fonts
      vim.g.db.ui_use_nerd_fonts = 0
      -- Setup vim-dadbod-ui
      require("vim-dadbod-ui").setup({}) -- The empty table is fine if you're adding the autocmd separately

      -- The autocmd to enable completion for sql/mysql filetypes
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql" },
        callback = function()
          -- Note: If you use the standard LunarVim setup, 'cmp' is already loaded.
          -- Ensure this setup uses your existing cmp configuration if needed.
          require('cmp').setup.buffer({
            sources = {
              { name = 'vim-dadbod-completion' }
            }
          })
        end
      })
    end,
    -- Optional: ensure it only loads when you execute a command related to it
    cmd = "DBUIToggle"
  }
}
