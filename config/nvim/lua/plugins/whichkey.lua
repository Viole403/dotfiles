-- plugins/whichkey.lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    preset = "modern",
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
      ellipsis = "…",
      mappings = false,  -- Disable Nerd Font icons
      keys = {
        Up = "↑",
        Down = "↓",
        Left = "←",
        Right = "→",
        C = "Ctrl-",
        M = "Alt-",
        S = "Shift-",
        CR = "Enter",
        Esc = "Esc",
        ScrollWheelDown = "ScrollDown",
        ScrollWheelUp = "ScrollUp",
        NL = "Enter",
        BS = "Backspace",
        Space = "Space",
        Tab = "Tab",
      },
    },
    win = {
      border = "rounded",
      padding = { 1, 2 },
      title = true,
      title_pos = "center",
      zindex = 1000,
    },
    layout = {
      width = { min = 20, max = 50 },
      height = { min = 4, max = 25 },
      spacing = 3,
      align = "left",
    },
    show_help = true,
    show_keys = true,
    triggers = {
      { "<auto>", mode = "nxsot" },
    },
    -- Define keymap groups and categories
    spec = {
      -- File & Find Operations
      { "<leader>f", group = "Find" },
      { "<leader>ff", desc = "Find files" },
      { "<leader>fg", desc = "Live grep" },
      { "<leader>fb", desc = "Find buffers" },
      { "<leader>fh", desc = "Find help tags" },
      { "<leader>ft", desc = "Find todos" },

      -- Buffer Operations
      { "<leader>b", group = "Buffer" },
      { "<leader>bd", desc = "Delete buffer" },
      { "<leader>bp", desc = "Pick buffer" },
      { "<Tab>", desc = "Next buffer" },
      { "<S-Tab>", desc = "Previous buffer" },

      -- File Explorer
      { "<leader>e", desc = "Toggle file explorer" },

      -- Project Management
      { "<leader>p", group = "Project" },
      { "<leader>pd", desc = "Find projects" },

      -- LSP Operations
      { "<leader>r", group = "Refactor" },
      { "<leader>rn", desc = "Rename symbol" },
      { "<leader>c", group = "Code" },
      { "<leader>ca", desc = "Code actions" },
      { "gd", desc = "Go to definition" },
      { "gr", desc = "Go to references" },
      { "K", desc = "Hover documentation" },

      -- Minimap
      { "<leader>m", group = "Minimap" },
      { "<leader>mm", desc = "Toggle minimap" },

      -- Todo Navigation
      { "]t", desc = "Next todo" },
      { "[t", desc = "Previous todo" },

      -- Terminal
      { "<A-`>", desc = "Toggle terminal" },

      -- Tmux Navigation
      { "<C-h>", desc = "Navigate left (Tmux)" },
      { "<C-j>", desc = "Navigate down (Tmux)" },
      { "<C-k>", desc = "Navigate up (Tmux)" },
      { "<C-l>", desc = "Navigate right (Tmux)" },
      { "<C-\\>", desc = "Navigate last active (Tmux)" },

      -- System Operations
      { "<C-S-c>", desc = "Copy to system clipboard", mode = "v" },
      { "<C-S-v>", desc = "Paste from system clipboard", mode = { "n", "i" } },

      -- Git Operations (from gitsigns - typical mappings)
      { "<leader>h", group = "Git Hunk" },
      { "<leader>t", group = "Toggle" },
      { "]c", desc = "Next git hunk" },
      { "[c", desc = "Previous git hunk" },

      -- Database UI
      { "<leader>d", group = "Database" },

      -- Which-Key Helper
      { "<leader>?", desc = "Buffer local keymaps" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}