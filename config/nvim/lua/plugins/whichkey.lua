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
    -- Sort mappings alphabetically and by groups
    sort = { "alphanum", "group", "local", "order", "mod" },
    -- Expand all groups to show all keymaps
    expand = 1000, -- Show all mappings (very high number)
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
      -- Transparent background for better visibility
      wo = {
        winblend = 0,
      },
    },
    layout = {
      width = { min = 20, max = 80 },  -- Wider window
      height = { min = 4, max = 40 },  -- Taller window
      spacing = 3,
      align = "left",
    },
    show_help = true,
    show_keys = true,
    -- Enable hydra mode for sticky key sequences
    triggers = {
      { "<auto>", mode = "nxsot" },
    },
    -- Defer showing popup for visual/visual-block mode (hydra mode)
    defer = function(ctx)
      return ctx.mode == "V" or ctx.mode == "<C-V>"
    end,
    -- Define keymap groups and categories (sorted alphabetically)
    spec = {
      -- ==================== LEADER KEY GROUPS ====================

      -- Buffer Operations
      { "<leader>b", group = "Buffer" },
      { "<leader>bd", desc = "Delete buffer" },
      { "<leader>bp", desc = "Pick buffer" },

      -- Code & LSP Operations
      { "<leader>c", group = "Code" },
      { "<leader>ca", desc = "Code actions" },
      { "<leader>cl", desc = "LSP Definitions" },
      { "<leader>cs", desc = "Symbols (Trouble)" },

      -- Database UI
      { "<leader>d", group = "Database" },

      -- File Explorer
      { "<leader>e", desc = "Toggle file explorer" },

      -- Find Operations (Telescope)
      { "<leader>f", group = "Find" },
      { "<leader>fb", desc = "Find buffers" },
      { "<leader>ff", desc = "Find files" },
      { "<leader>fg", desc = "Live grep" },
      { "<leader>fh", desc = "Find help tags" },
      { "<leader>ft", desc = "Find todos" },

      -- Git Hunk Operations
      { "<leader>h", group = "Git Hunk" },
      { "<leader>hb", desc = "Blame line" },
      { "<leader>hd", desc = "Diff this" },
      { "<leader>hD", desc = "Diff this ~" },
      { "<leader>hp", desc = "Preview hunk" },
      { "<leader>hq", desc = "Set qflist" },
      { "<leader>hQ", desc = "Set qflist (all)" },
      { "<leader>hr", desc = "Reset hunk" },
      { "<leader>hR", desc = "Reset buffer" },
      { "<leader>hs", desc = "Stage hunk" },
      { "<leader>hS", desc = "Stage buffer" },

      -- Minimap
      { "<leader>m", group = "Minimap" },
      { "<leader>mm", desc = "Toggle minimap" },

      -- Project Management
      { "<leader>p", group = "Project" },
      { "<leader>pd", desc = "Find projects" },

      -- Refactor Operations
      { "<leader>r", group = "Refactor" },
      { "<leader>rn", desc = "Rename symbol" },

      -- Toggle Operations
      { "<leader>t", group = "Toggle" },
      { "<leader>tb", desc = "Toggle line blame" },
      { "<leader>tw", desc = "Toggle word diff" },

      -- Trouble (Diagnostics)
      { "<leader>x", group = "Diagnostics" },
      { "<leader>xL", desc = "Location List" },
      { "<leader>xQ", desc = "Quickfix List" },
      { "<leader>xx", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", desc = "Buffer Diagnostics" },

      -- Which-Key Helper
      { "<leader>?", desc = "Buffer local keymaps" },

      -- ==================== NON-LEADER KEYS ====================

      -- Buffer Navigation
      { "<Tab>", desc = "Next buffer" },
      { "<S-Tab>", desc = "Previous buffer" },

      -- Terminal
      { "<A-`>", desc = "Toggle terminal" },

      -- Autopairs Fast Wrap
      { "<M-e>", desc = "Fast wrap (autopairs)", mode = "i" },

      -- Flash Navigation
      { "s", desc = "Flash jump", mode = { "n", "x", "o" } },
      { "S", desc = "Flash Treesitter", mode = { "n", "x", "o" } },
      { "r", desc = "Remote Flash", mode = "o" },
      { "R", desc = "Treesitter Search", mode = { "o", "x" } },
      { "<c-s>", desc = "Toggle Flash Search", mode = "c" },

      -- LSP Operations
      { "gd", desc = "Go to definition" },
      { "gr", desc = "Go to references" },
      { "K", desc = "Hover documentation" },

      -- Git Hunk Navigation
      { "]c", desc = "Next git hunk" },
      { "[c", desc = "Previous git hunk" },

      -- Todo Navigation
      { "]t", desc = "Next todo" },
      { "[t", desc = "Previous todo" },

      -- Tmux Navigation
      { "<C-h>", desc = "Navigate left (Tmux)" },
      { "<C-j>", desc = "Navigate down (Tmux)" },
      { "<C-k>", desc = "Navigate up (Tmux)" },
      { "<C-l>", desc = "Navigate right (Tmux)" },
      { "<C-\\>", desc = "Navigate last active (Tmux)" },

      -- System Clipboard
      { "<C-S-c>", desc = "Copy to clipboard", mode = "v" },
      { "<C-S-v>", desc = "Paste from clipboard", mode = { "n", "i" } },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = true })  -- Show ALL keymaps (global + buffer-local)
      end,
      desc = "Show all keymaps (which-key)",
    },
    {
      "<leader>?b",
      function()
        require("which-key").show({ global = false })  -- Show only buffer-local
      end,
      desc = "Show buffer keymaps",
    },
  },
}