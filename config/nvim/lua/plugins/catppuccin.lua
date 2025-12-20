-- plugins/catppuccin.lua
return {
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
      auto_integrations = true,
      integrations = {
        cmp = true,            -- Add nvim-cmp integration
        gitsigns = true,  -- Add Gitsigns integration
        treesitter = true,    -- Add Treesitter integration
        telescope = true,      -- Add Telescope integration
        rainbow_delimiters = true, -- Add Rainbow Delimiters integration
        alpha = true,           -- Add Alpha integration
        nvimtree = true,         -- Add NvimTree integration
        flash_nvim = true,           -- Add Flash integration
        which_key = true,           -- Add Which Key integration
        -- Add Indent Blankline integration
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
        },
        -- Add native LSP integration
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
}